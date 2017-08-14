class SupportsController < ApplicationController
    def new
        @support = Support.new
    end

    def create
        @support = Support.new(support_params)
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
          params.require(:support).permit(:name, :media_type_id, :sourceLanguage_id, :targetLanguage_id, :user_id)
        end
end
