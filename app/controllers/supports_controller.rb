class SupportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_support, only: %i[edit update destroy archive]
  before_action :confirm_user, :check_deleted_support_access, only: %i[edit update destroy]

  def new
    @support = Support.new
  end

  def create
    @support = Support.new(support_params)
    @support.save
  end

  def edit; end

  def update
    if @support.update(support_params)
      redirect_to support_translations_path(@support), notice: 'Le media a bien été modifié.'
    else
      render 'edit'
    end
  end

  def archive
    @support.archive_at = (@support.archive_at.nil? ? DateTime.now : nil)
    redirect_to root_path if @support.save
  end

  def destroy
    @support.deleted_at = DateTime.now
    @support.archive_at = nil
    redirect_to home_index_path, notice: 'The list has been deleted with success.' if @support.save
  end

  private

  def support_params
    params.require(:support).permit(:name, :media_type_id,
                                    :sourceLanguage_id, :targetLanguage_id,
                                    :user_id)
  end

  def check_deleted_support_access
    return if @support.deleted_at.nil?
    render file: 'public/404.html', layout: 'error', status: 404
  end

  def confirm_user
    return if current_user == @support.user
    render file: 'public/403.html', layout: 'error', status: 403
  end

  def set_support
    @support = Support.find(params[:id])
  end
end
