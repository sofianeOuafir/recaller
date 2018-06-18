class TranslationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_access_to_support, only: %i[index create]
  before_action :restrict_access_to_translation, only: %i[edit update destroy]

  def index
    @support = Support.find(params[:support_id])
    @translations = Translations::FetchAll.process(@support)
    @translation = Translation.new
  end

  def create
    @support = Support.find(params[:support_id])
    source = Writings::Creator.process(
      text: params[:translation][:sourceWriting],
      language_id: @support.sourceLanguage.code
    )
    target = Writings::Creator.process(
      text: params[:translation][:targetWriting],
      language_id: @support.targetLanguage.code
    )
    @translation = Translations::Creator.create(
      support_id: @support.id,
      context: params[:translation][:context],
      targetWriting_id: target.id,
      sourceWriting_id: source.id
    )
  end

  def destroy
    @translation = Translation.find(params[:id])
    Translations::Destroyer.process(@translation)
  end

  def edit
    @translation = Translation.find(params[:id])
    @support = @translation.support
  end

  def update
    @support = Support.find(params[:support_id])
    @translation = Translation.find(params[:id])
    source = Writings::Creator.process(
      text: params[:translation][:sourceWriting],
      language_id: @support.sourceLanguage.code
    )
    target = Writings::Creator.process(
      text: params[:translation][:targetWriting],
      language_id: @support.targetLanguage.code
    )
    @translation.update(
      support_id: @support.id,
      context: params[:translation][:context],
      targetWriting_id: target.id,
      sourceWriting_id: source.id
    )
    redirect_to support_translations_path(@translation.support)
  end

  private

  def translation_params
    params.require(:translation)
          .permit(:context, :support_id, :deleted_at,
                  :sourceWriting_id, :targetWriting_id)
  end

  def restrict_access_to_support
    support = Support.find(params[:support_id])
    confirm_user(support)
    check_deleted_support_access(support)
  end

  def restrict_access_to_translation
    support = Translation.find(params[:id]).support
    confirm_user(support)
    check_deleted_support_access(support)
  end

  def confirm_user(support)
    return if current_user == support.user
    render file: 'public/403.html', layout: 'error', status: 403
  end

  def check_deleted_support_access(support)
    return if support.deleted_at.nil?
    render file: 'public/404.html', layout: 'error', status: 404
  end
end
