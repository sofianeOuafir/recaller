class FrenchToGermanDictionaryController < ApplicationController
  def index
    render json: Dictionaries::TranslationFetcher.new(phrase: params[:phrase], from: 'fra', dest: 'deu').translate.to_json
  end
end
