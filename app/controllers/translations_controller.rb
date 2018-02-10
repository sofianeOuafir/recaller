class TranslationsController < ApplicationController
    before_action :authenticate_user!, :set_supports
    before_action :restrict_access

    def index
        @support = Support.find(params[:support_id])
        @translations = @support.translations
        @translation = Translation.new
    end

    def create
        @support = Support.find(params[:support_id])
        @translation = Translation.new
        @translation.sourceWriting = Writing.find_or_create_by(text: params[:translation][:sourceWriting], language_id: @support.sourceLanguage.code)
        @translation.targetWriting = Writing.find_or_create_by(text: params[:translation][:targetWriting], language_id: @support.targetLanguage.code)
        @translation.context = params[:translation][:context]
        @translation.support = @support
        if @translation.save
            respond_to do |format|
              format.js
            end
        end
    end

    def destroy
        @translation = Translation.find(params[:id])
        if @translation.destroy
          respond_to do |format|
            format.js
          end
        end
    end

    def edit
        @translation = Translation.find(params[:id])
        @support = @translation.support
    end

    def update
        @translation = Translation.find(params[:id])

        #if the translation has been updated
        if @translation.sourceWriting.text != params[:translation][:sourceWriting] || @translation.targetWriting.text != params[:translation][:targetWriting] || @translation.context != params[:translation][:context]
            #if the sourceWriting has been updated
            if @translation.sourceWriting.text != params[:translation][:sourceWriting]
                @sourceWriting = Writing.find_by_text_and_language_id(params[:translation][:sourceWriting], @translation.support.sourceLanguage.code)
                if @sourceWriting == nil
                    @sourceWriting = Writing.new(text: params[:translation][:sourceWriting], language_id: @translation.support.sourceLanguage.code)
                    if !@sourceWriting.save
                      respond_to do |format|
                        format.js{
                          render :action => 'writing_errors' and return
                        }
                      end
                    end
                end
                @translation.sourceWriting = @sourceWriting
            end

            #if the targetWriting has been modified
            if @translation.targetWriting.text != params[:translation][:targetWriting]
                @targetWriting = Writing.find_by_text_and_language_id(params[:translation][:targetWriting], @translation.support.targetLanguage.code)
                if @targetWriting == nil
                    @targetWriting = Writing.new(text: params[:translation][:targetWriting], language_id: @translation.support.targetLanguage.code)
                    if !@targetWriting.save
                      respond_to do |format|
                        format.js{
                          render :action => 'writing_errors' and return
                        }
                      end
                    end
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

        def restrict_access
            begin
                support = Support.find(params[:support_id])
                if action_name == "index" || action_name == "create"
                    if current_user != support.user
                        logger.error "403 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:support_id]} wheras he is not the owner of that resource"
                        render file: 'public/403.html', layout: 'error', status: 403 and return
                    elsif support.deleted_at != nil
                        logger.error "404 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:id]} wheras this resource has been deleted before"
                        render file: 'public/404.html', layout: 'error', status: 404 and return
                    end
                else
                    if current_user != Translation.find(params[:id]).support.user
                        logger.error "403 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the translation #{params[:id]} wheras he is not the owner of that resource"
                        render file: 'public/403.html', layout: 'error', status: 403 and return
                    elsif current_user != support.user
                        logger.error "403 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:support_id]} wheras he is not the owner of that resource"
                        render file: 'public/403.html', layout: 'error', status: 403 and return
                    elsif support.deleted_at != nil
                        logger.error "404 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:id]} wheras this resource has been deleted before"
                        render file: 'public/404.html', layout: 'error', status: 404 and return
                    end
                end
            rescue
                logger.info "404 page not found error -> the user #{current_user.username}, id #{current_user.id} tried to access a resource that does not exists"
                render file: 'public/404.html', layout: 'error', status: 404 and return
            end
        end
end
