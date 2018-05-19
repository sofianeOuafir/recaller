class SublistsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # TODO create a Sublists::Creator
    support = Support.new(support_params)
    support.save
    params[:translation].each do |translation_id|
      translation = Translation.find(translation_id)
      new_translation = Translation.new(context: translation.context,
                                        support_id: support.id,
                                        targetWriting_id: translation.targetWriting_id,
                                        sourceWriting_id: translation.sourceWriting_id
                                       ).save
    end
  end

  private

  def support_params
    params.require(:support).permit(:name, :media_type_id,
                                    :sourceLanguage_id, :targetLanguage_id,
                                    :user_id, :support_id)
  end
end