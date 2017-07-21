require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @support = Support.new(name:"Harry Potter", media_type_id: media_types(:book).id, sourceLanguage_id: languages(:français).code, targetLanguage_id: languages(:français).code, user_id: users(:sofiane).id)
  end

  test "should be valid" do
    assert @support.valid?
  end

  test "name should not be blank" do
    @support.name = "   "
    assert_not @support.valid?
  end

  test "name should be at least 2 characters long" do
    @support.name = "a"
    assert_not @support.valid?
  end

  test "name should be at most 255 characters long" do
    @support.name = "a" * 256
    assert_not @support.valid?
  end

  test "spaces should be trimmed in names" do
    name = " harry potter "
    @support.name = name
    @support.valid?

    assert_equal name.strip, @support.name
  end

  test "first letter of name should be upcased before save" do
    name = "harry potter"
    @support.name = name
    @support.save
    assert_equal name.capitalize, @support.name
  end

  test "user_id should exist" do
    @support.user_id = 9999
    assert_not @support.valid?
  end

  test "user_id should not be nil" do
    @support.user_id = nil
    assert_not  @support.valid?
  end

  test "StatementInvalid exception should be raised if trying to delete a support's user" do
    @support.save
    assert_raises ActiveRecord::StatementInvalid, "It should not be possible to delete a support's user" do
        @support.user.delete
    end
  end

  test "Media type should exist" do
    @support.media_type_id = 9999
    assert_not @support.valid?
  end

  test "media type should never be nil" do
    @support.media_type_id = nil
    assert_not @support.valid?
  end

  test "StateInvalid exception should be raised if trying to delete a support's mediatype" do
    @support.save
    assert_raises ActiveRecord::StatementInvalid, "it should not be possible to delete a support's mediatype" do
        @support.media_type.delete
    end
  end

  test "Language should exist" do
    @support.sourceLanguage_id = "not exist language code"
    assert_not @support.valid?
  end

  test "Language should never be nil" do
    @support.sourceLanguage_id = nil
    assert_not @support.valid?
  end

  test "StateInvalid exception should be raised if trying to delete a support's language" do
    @support.save
    assert_raises ActiveRecord::StatementInvalid, "it should not be possible to delete a support's language" do
        @support.sourceLanguage.delete
    end
  end

  test "language should be on update cascade" do
    new_code = "en"
    Language.find_by(code:"fr").update_attributes(code:new_code)
    assert_equal new_code, Support.first.sourceLanguage.code
    assert_equal new_code, Support.first.targetLanguage.code
  end
end
