require 'test_helper'

class TranslationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @support = supports(:harryPotter)
    @translation = translations(:one)
  end

  test "should get index" do
    get support_translations_url(@support)
    assert_response :success
  end

  test "should create translation" do
    assert_difference('Translation.count') do
      post support_translations_url, params: { translation: { context: @translation.context, support_id: @translation.support_id, sourceLanguage_id: @translation.sourceLanguage_id, targetLanguage_id: @translation.targetLanguage_id } }
    end

    assert_redirected_to support_translation_url(Translation.last)
  end

  test "should show translation" do
    get translation_url(@translation)
    assert_response :success
  end

  test "should get edit" do
    get edit_translation_url(@translation)
    assert_response :success
  end

  test "should update translation" do
    patch translation_url(@translation), params: { translation: {  } }
    assert_redirected_to translation_url(@translation)
  end

  test "should destroy translation" do
    assert_difference('Translation.count', -1) do
      delete translation_url(@translation)
    end

    assert_redirected_to translations_url
  end
end
