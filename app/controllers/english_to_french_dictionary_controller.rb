class EnglishToFrenchDictionaryController < ApplicationController
  def index
    render json: Dictionaries::TranslationFetcher.new(phrase: params[:phrase], from: 'eng', dest: 'fra').translate.to_json
  end
end
