require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @language = Language.create(code:"en", name:"anglais")
  end

  test "should be valid" do
    assert @language.valid?
  end
end
