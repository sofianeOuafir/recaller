require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @support = Support.new(name:"Harry Potter", media_type_id: 980190962, sourceLanguage_id: "fr", targetLanguage_id: "fr", user_id: 980190962)
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
    @support.save

    assert_equal name.strip, @support.name
  end
end
