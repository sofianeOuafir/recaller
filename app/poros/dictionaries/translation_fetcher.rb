class Dictionaries::TranslationFetcher
  include HTTParty
  base_uri 'https://glosbe.com'

  attr_accessor :body
  def initialize(phrase:, from:, dest:)
    self.class.headers 'Content-Type' => 'application/json'
    @body = { query: { 'from': from, 'dest': dest, 'format': 'json', 'phrase': phrase, 'pretty': true} }
  end

  def translate
    self.class.get("/gapi/translate", body)
  end
end
