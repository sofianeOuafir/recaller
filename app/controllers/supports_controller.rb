class SupportsController < ApplicationController
    before_action :authenticate_user!, :set_supports
    before_action :restrict_access, only: [:edit, :update, :destroy]

    def new
        @support = Support.new
    end

    def create
        @support = Support.new(support_params)
        @support.user_id = current_user.id
        if @support.save
            flash[:notice] = "Le media a bien été enregistré."
            redirect_to support_translations_path(@support)
        else
            render 'new', status: 400
        end
    end

    def edit
        @support = Support.find(params[:id])
    end

    def update
        @support = Support.find(params[:id])
        if @support.update(support_params)
            flash[:notice] = "Le media a bien été modifié."
            redirect_to support_translations_path(@support)
        else
            render 'edit', status: 400
        end
    end

    def archive
        @support = Support.find(params[:id])
        if @support.archive_at == nil
            @support.archive_at = DateTime.now
        else
            @support.archive_at = nil
        end 

        if @support.save
            redirect_to root_path
        end
    end

    def destroy
        @support = Support.find(params[:id])
        @support.deleted_at = DateTime.now
        @support.archive_at = nil
        if @support.save
            flash[:notice] = "Le media a bien été supprimé."
            redirect_to controller: :home, action: :index
        end
    end
    
    private
        def support_params
          params.require(:support).permit(:name, :media_type_id, :sourceLanguage_id, :targetLanguage_id)
        end

        def restrict_access
            begin
                support = Support.find(params[:id])
                if current_user != support.user
                    logger.error "403 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:id]} wheras he is not the owner of that resource"
                    render file: 'public/403.html', layout: 'error', status: 403 and return
                elsif support.deleted_at != nil
                    logger.error "404 forbidden error -> the user #{current_user.username}, id #{current_user.id} tried to access the support #{params[:id]} wheras this resource has been deleted before"
                    render file: 'public/404.html', layout: 'error', status: 404 and return
                end
            rescue
                logger.info "404 page not found error -> the user #{current_user.username}, id #{current_user.id} tried to access a resource that does not exists"
                render file: 'public/404.html', layout: 'error', status: 404 and return
            end
        end
end
