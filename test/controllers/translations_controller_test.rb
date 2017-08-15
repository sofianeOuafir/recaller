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
  
  #TODO Test all cases where create should fail
  test "should create translation" do
    assert_difference('Translation.count') do
      post support_translations_url(@translation.support), params: {translation: { context: @translation.context, support_id: @translation.support_id, sourceWriting: "Bonjour", targetWriting: "Hello"} }, xhr: true
    end

    assert_equal "text/javascript", @response.content_type
    assert_response :success
    assert_equal "create", @controller.action_name
  end

  test "should get edit" do
    get edit_support_translation_url(@translation.support, @translation)
    assert_response :success
  end

  test "should fail trying to get edit" do
    @translation.id = 99
    get edit_support_translation_url(@translation.support, @translation)
    assert_response :not_found
  end

  #TODO Test all cases where update should fail
  test "should update translation" do
    patch support_translation_url(@translation.support, @translation), params: { translation: { sourceWriting: "Updated", targetWriting: "Updated", context: "Updated" } }
    @translation.reload
    assert_equal "Updated", @translation.sourceWriting.text
    assert_equal "Updated", @translation.targetWriting.text
    assert_equal "Updated", @translation.context
    assert_equal "update", @controller.action_name
    assert_redirected_to support_translations_url(@translation.support)
  end

  test "should destroy translation" do
    assert_difference('Translation.count', -1) do
      delete support_translation_url(@translation.support, @translation), xhr: true
    end
    assert_response :success
    assert_equal "destroy", @controller.action_name
    assert_equal "application/x-www-form-urlencoded", @request.media_type
    assert_equal "text/javascript", @response.content_type
  end

  test "should fail trying to destroy translation" do
    @translation.id = 99
    assert_no_difference('Translation.count') do
      delete support_translation_url(@translation.support, @translation), xhr: true
    end
    assert_equal "destroy", @controller.action_name
    assert_response :not_found
  end
end
