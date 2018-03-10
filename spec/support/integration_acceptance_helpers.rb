module IntegrationAcceptanceHelpers
  def create_support
    create(:support, user: create(:user),
                     media_type: create_book_media_type,
                     sourceLanguage: create_french_language,
                     targetLanguage: create_english_language)
  end

  def create_book_media_type
    create(:media_type, :book)
  end

  def create_french_language
    create(:language, :french)
  end

  def create_english_language
    create(:language, :english)
  end

  def create_review
    create(:review, support: create_support)
  end

  def create_writing
    create(:writing, text:'Hello', language: create_french_language)
  end

  def create_translation
    support = create_support
    writing = create(:writing, text:'Hello', language: support.sourceLanguage)
    create(:translation, support: support,
                         sourceWriting: writing,
                         targetWriting: writing,
                         context: '')
  end
end
