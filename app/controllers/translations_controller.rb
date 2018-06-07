class TranslationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_access_to_support, only: %i[index create]
  before_action :restrict_access_to_translation, only: %i[edit update destroy]
  before_action :set_translation, only: %i[edit update destroy]

  def index
    @support = Support.find(params[:support_id])
    @translations = Translations::FetchAll.process(@support)
    @translation = Translation.new
  end

  def create
    @support = Support.find(params[:support_id])
    source = Writings::Creator.new(
      text: params[:translation][:sourceWriting],
      language_id: @support.sourceLanguage.code
    ).process
    target = Writings::Creator.new(
      text: params[:translation][:targetWriting],
      language_id: @support.targetLanguage.code
    ).process
    @translation = Translations::Creator.create(
      support_id: @support.id,
      context: params[:translation][:context],
      targetWriting_id: target.id,
      sourceWriting_id: source.id
    )
  end

  def destroy
    Translations::Destroyer.process(@translation)
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
