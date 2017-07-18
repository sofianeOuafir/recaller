require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @language = Language.new(code:"en", name:"anglais")
  end

  test "should be valid" do
    assert @language.valid?
  end

  test "code should not be blank" do
    @language.code = "   "
    assert_not @language.valid?
  end

  test "code must be 2 characters long" do
    @language.code = "fra"
    assert_not @language.valid?
  end

  test "name should not be blank" do
    @language.name = "    "
    assert_not @language.valid?
  end

  test "name should be at least 2 characters long" do
    @language.name = "a"
    assert_not @language.valid?
  end

  test "name should be at most 50 characters long" do
    @language.name = "a" * 51
    assert_not @language.valid?
  end

  test "name should be trimmed before validation" do
    name = " anglais "
    @language.name = name
    @language.valid?
    assert_equal name.strip, @language.name
  end

    test "code should be trimmed before validation" do
      code = "f "
      @language.code = code
      @language.valid?
      assert_equal code.strip, @language.code
    end
end
