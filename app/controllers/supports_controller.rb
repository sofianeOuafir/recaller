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
        begin
            @support = Support.find(params[:id])
        rescue
            render file: 'public/404.html', status: 404, layout: false
        end
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

    def destroy
        @support = Support.find(params[:id])
        @support.destroy
        flash[:notice] = "Le media a bien été supprimé."
        redirect_to controller: :home, action: :index
    end
    
    private
        def support_params
          params.require(:support).permit(:name, :media_type_id, :sourceLanguage_id, :targetLanguage_id)
        end

        def restrict_access
            begin
                if current_user != Support.find(params[:id]).user
                    flash[:notice] = "Vous n'êtes pas autorisé à accéder à ce contenu."
                    redirect_to root_path
                end
            rescue
                render file: 'public/404.html', layout: false, status: 404
            end
        end
end
