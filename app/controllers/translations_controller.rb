class TranslationsController < ApplicationController
    def index
        begin
            @support = Support.find(params[:support_id])
            @translations = @support.translations
        rescue
            render file: 'public/404.html'
        end
    end

    def destroy
        begin
            @support = Support.find(params[:support_id])
            @translation = Translation.find(params[:id])
            @translation.destroy
            redirect_to support_translations_path(@support)
        rescue
            render file: 'public/404.html'
        end
    end
end
