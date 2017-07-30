require 'test_helper'

class WritingTest < ActiveSupport::TestCase
    def setup
        @writing = Writing.new(text:"Bonjour", language_id: "de")
    end

    test "should be valid" do
        assert @writing.valid?
    end

    test "text should not be blank" do
        @writing.text = "     "
        assert_not @writing.valid?
    end

    test "text should have at least 2 characters" do
        @writing.text = "a"
        assert_not @writing.valid?
    end

    test "text should have at most 255 characters" do
        @writing.text = "a" * 256
        assert_not @writing.valid?
    end

    test "text should be trimmed before validation" do
        text = " Bonjour "
        @writing.text = text
        @writing.valid?
        assert_equal text.strip, @writing.text
    end

    test "text should be capitalized before save" do
        text = "bonjour"
        @writing.text = text
        @writing.save
        assert_equal text.capitalize, @writing.text
    end

    test "StatementInvalid error should be thrown if trying to delete a writing's language" do
        @writing.save
        assert_raises ActiveRecord::StatementInvalid do
            @writing.language.delete
        end
    end

    test "if updating a writing's language, the update should be on update cascade" do
        w = Writing.first
        code = "uu"
        Language.find_by(code:w.language_id).update_attributes(code: code)
        assert_equal code, w.reload.language_id
    end

    test "(text,language_id) should be unique" do
        @writing.language_id = "fr"
        assert_not @writing.valid?
    end
end
