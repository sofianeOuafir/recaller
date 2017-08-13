class SupportsController < ApplicationController
    def new
        @support = Support.new
    end

    def create
        @support = Support.new(support_params)
        if @support.save
            redirect_to support_translations_path(@support)
        else
            render 'new'
        end
    end

    def edit
        begin
            @support = Support.find(params[:id])
        rescue
            render file: 'public/404.html'
        end
    end

    def update
        @support = Support.find(params[:id])
        if @support.update(support_params)
            redirect_to support_translations_path(@support)
        else
            render 'edit'
        end
    end

    def destroy
        @support = Support.find(params[:id])
        @support.destroy

        redirect_to controller: :home, action: :index
    end
    
    private
        def support_params
          params.require(:support).permit(:name, :media_type_id, :sourceLanguage_id, :targetLanguage_id, :user_id)
        end
end
