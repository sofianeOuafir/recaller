require 'test_helper'

class SupportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @support = supports(:shapeOfYou)
  end

  test "should get new" do
    get new_support_url
    assert_equal "new", @controller.action_name
    assert_response :success
  end

  test "should create support" do
    assert_difference('Support.count') do
      post supports_url, params: { support: { name:"Harry Potter", sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id, media_type_id: media_types(:book).id } }
    end
    assert_equal "create", @controller.action_name
    assert_equal "Le media a bien été enregistré.", flash[:notice]
    assert_redirected_to support_translations_path(Support.last)
  end

  test "should fail trying to create a support" do
    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"H", sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id, media_type_id: media_types(:book).id } }
    end
    assert_response :bad_request

    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"H" * 256, sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id, media_type_id: media_types(:book).id } }
    end
    assert_response :bad_request

    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"Harry Potter", sourceLanguage_id: "not_exists", targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id, media_type_id: media_types(:book).id } }
    end
    assert_response :bad_request

    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"Harry Potter", sourceLanguage_id: languages(:français).code, targetLanguage_id: "not_exists", user_id: users(:sofiane).id, media_type_id: media_types(:book).id } }
    end
    assert_response :bad_request

    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"Harry Potter", sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: 99, media_type_id: media_types(:book).id } }
    end
    assert_response :bad_request

    assert_no_difference('Support.count') do
      post supports_url, params: { support: { name:"Harry Potter", sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id, media_type_id: 99 } }
    end
    assert_response :bad_request
  end



  test "should get edit" do
    get edit_support_url(@support)
    assert_equal "edit", @controller.action_name
    assert_response :success
  end

  test "should fail trying to get edit" do
    @support.id = 99
    get edit_support_url(@support)
    assert_response :not_found
  end

  test "should update support" do
    patch support_url(@support), params: { support: { name:"Alice in wonderland"} }
    assert_equal "update", @controller.action_name
    assert_equal "Le media a bien été modifié.", flash[:notice]
    assert_redirected_to support_translations_url(@support)
    @support.reload
    assert_equal "Alice in wonderland", @support.name
  end

  test "should fail trying to update support" do
    patch support_url(@support), params: {support: {name: ""}}
    assert_response :bad_request
    patch support_url(@support), params: {support: {name: "h"}}
    assert_response :bad_request
    patch support_url(@support), params: {support: {name: "h" * 256}}
    assert_response :bad_request
    patch support_url(@support), params: {support:{ sourceLanguage_id: "not exists"}}
    assert_response :bad_request
    patch support_url(@support), params: {support:{ targetLanguage_id: "not exists"}}
    assert_response :bad_request
    patch support_url(@support), params: {support:{ media_type_id: 99}}
    assert_response :bad_request
    patch support_url(@support), params: {support:{ user_id: 99}}
    assert_response :bad_request
  end

  #TODO I have to work on the destroy policy for supports (archive, delete...)
  test "should destroy support" do
    assert_difference('Support.count', -1) do
      delete support_url(@support)
    end

    assert_equal "destroy", @controller.action_name
    assert_equal "Le media a bien été supprimé.", flash[:notice]
    assert_redirected_to home_index_url
  end
end
