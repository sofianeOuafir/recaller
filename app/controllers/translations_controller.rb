class TranslationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_access_to_support, only: %i[index create]
  before_action :restrict_access_to_translation, only: %i[edit update destroy]
  before_action :set_translation, only: %i[edit update destroy]

  def index
    @support = Support.find(params[:support_id])
    @translations = @support.translations
    @translation = Translation.new
  end

  def create
    @support = Support.find(params[:support_id])
    @translation = Translation.new(translation_params)
    @translation.sourceWriting =
      Writing.find_or_create_by(text: params[:translation][:sourceWriting],
                                language_id: @support.sourceLanguage.code)
    @translation.targetWriting =
      Writing.find_or_create_by(text: params[:translation][:targetWriting],
                                language_id: @support.targetLanguage.code)
    @translation.save
  end

  def destroy
    @translation.destroy
  end

  def edit
    @support = @translation.support
  end

  def update
      #if the translation has been updated
      if @translation.sourceWriting.text != params[:translation][:sourceWriting] || @translation.targetWriting.text != params[:translation][:targetWriting] || @translation.context != params[:translation][:context]
          #if the sourceWriting has been updated
          if @translation.sourceWriting.text != params[:translation][:sourceWriting]
              @sourceWriting = Writing.find_by_text_and_language_id(params[:translation][:sourceWriting], @translation.support.sourceLanguage.code)
              if @sourceWriting == nil
                @sourceWriting = Writing.new(text: params[:translation][:sourceWriting], language_id: @translation.support.sourceLanguage.code)
                @sourceWriting.save
              end
              @translation.sourceWriting = @sourceWriting
          end

          #if the targetWriting has been modified
          if @translation.targetWriting.text != params[:translation][:targetWriting]
              @targetWriting = Writing.find_by_text_and_language_id(params[:translation][:targetWriting], @translation.support.targetLanguage.code)
              if @targetWriting == nil
                @targetWriting = Writing.new(text: params[:translation][:targetWriting], language_id: @translation.support.targetLanguage.code)
                @targetWriting.save
              end
              @translation.targetWriting = @targetWriting
          end

          #if the context has been modified
          if @translation.context != params[:translation][:context]
              @translation.context = params[:translation][:context]
          end
          @translation.save
      end

      redirect_to support_translations_path(@translation.support)
  end

  private

  def translation_params
    params.require(:translation).permit(:context, :support_id)
  end

  def set_translation
    @translation = Translation.find(params[:id])
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
