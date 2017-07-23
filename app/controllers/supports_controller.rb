class SupportsController < ApplicationController
    def new
        @support = Support.new
    end

    def create
        @support = Support.new(support_params)
        if @support.save
            redirect_to controller: :home, action: :index
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
            @supports = Support.all
            render 'home/index'
        else
            render 'edit'
        end
    end

    def support_params
      params.require(:support).permit(:name, :media_type_id, :sourceLanguage_id, :targetLanguage_id, :user_id)
    end
end
