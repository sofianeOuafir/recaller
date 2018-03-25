class FrenchToEnglishDictionaryController < ApplicationController
  def index
    render json: Dictionaries::TranslationFetcher.new(phrase: params[:phrase], from: 'fra', dest: 'eng').translate.to_json
  end
end
