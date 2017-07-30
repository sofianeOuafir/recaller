class TranslationsController < ApplicationController
    def index
        begin
            @support = Support.find(params[:support_id])
            @translations = @support.translations
            @translation = Translation.new
        rescue
            render file: 'public/404.html', layout: false
        end
    end

    def create
        @support = Support.find(params[:support_id])
        @sourceWriting = Writing.find_by_text_and_language_id(params[:translation][:sourceWriting], @support.sourceLanguage.code)

        if @sourceWriting == nil
            @sourceWriting = Writing.create(text: params[:translation][:sourceWriting], language_id: @support.sourceLanguage.code)
        end

        @targetWriting = Writing.find_by_text_and_language_id(params[:translation][:targetWriting], @support.targetLanguage.code)

        if @targetWriting == nil
            @targetWriting = Writing.create(text: params[:translation][:targetWriting], language_id: @support.targetLanguage.code)
        end
        @support.translations.create(context: params[:translation][:context], sourceWriting: @sourceWriting, targetWriting: @targetWriting)
        redirect_to support_translations_path(@support)
    end

    def destroy
        begin
            @support = Support.find(params[:support_id])
            @translation = Translation.find(params[:id])
            @translation.destroy
            redirect_to support_translations_path(@support)
        rescue
            render file: 'public/404.html', layout: false
        end
    end

    def edit
        begin
            @support = Support.find(params[:support_id])
            @translation = Translation.find(params[:id])
        rescue
            render file: 'public/404.html', layout: false
        end
    end

    def update
        @translation = Translation.find(params[:id])

        if @translation.sourceWriting.text != params[:translation][:sourceWriting] || @translation.targetWriting.text != params[:translation][:targetWriting] || @translation.context != params[:translation][:context]
            #if the sourceWriting has been modified
            if @translation.sourceWriting.text != params[:translation][:sourceWriting]
                @sourceWriting = Writing.find_by_text_and_language_id(params[:translation][:sourceWriting], @translation.support.sourceLanguage.code)
                if @sourceWriting == nil
                    @sourceWriting = Writing.create(text: params[:translation][:sourceWriting], language_id: @translation.support.sourceLanguage.code)
                end
                @translation.sourceWriting = @sourceWriting
            end

            #if the targetWriting has been modified
            if @translation.targetWriting.text != params[:translation][:targetWriting]
                @targetWriting = Writing.find_by_text_and_language_id(params[:translation][:targetWriting], @translation.support.targetLanguage.code)
                if @targetWriting == nil
                    @targetWriting = Writing.create(text: params[:translation][:targetWriting], language_id: @translation.support.targetLanguage.code)
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
            params.require(:translation).permit(:sourceWriting, :context, :targetWriting)
        end
end
