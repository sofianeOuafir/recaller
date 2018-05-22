class SublistsController < ApplicationController
  def new
    @support = Support.find(params[:support_id])
    @translations = params[:translation]
    @topic = @support.build_support
  end

  def create
    @translations = params[:translation]
    @topic = Topics::Creator.process(
      params: support_params.to_hash,
      translations: Translation.where(id: @translations)
    )
    @support = @topic.support
  end

  private

  def support_params
    params.require(:support).permit(:name, :media_type_id,
                                    :sourceLanguage_id, :targetLanguage_id,
                                    :user_id, :support_id)
  end
end