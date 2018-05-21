class SublistsController < ApplicationController
  def new
    @support = Support.find(params[:support_id])
    @translations = params[:translation]
    @topic = @support.build_support
  end

  def create
    # TODO create a Sublists::Creator
    @topic = Support.new(support_params)
    @support = @topic.support
    @translations = params[:translation]
    if @topic.save
      @translations.try(:each) do |translation_id|
        translation = Translation.find(translation_id)
        new_translation = Translation.new(context: translation.context,
                                          support_id: @topic.id,
                                          targetWriting_id: translation.targetWriting_id,
                                          sourceWriting_id: translation.sourceWriting_id
                                        ).save
      end
    end
  end

  private

  def support_params
    params.require(:support).permit(:name, :media_type_id,
                                    :sourceLanguage_id, :targetLanguage_id,
                                    :user_id, :support_id)
  end
end