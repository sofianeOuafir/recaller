require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
    def setup
        @translation = Translation.new(context:"Hagrid à dit bonjour à Harry", sourceWriting_id:3, targetWriting_id:2, support_id:2)
    end

    test "should be valid" do
        assert @translation.valid?
    end

    test "context should be trimmed before validation" do
        context = " Hagrid à dit bonjour à Harry "
        @translation.context = context
        @translation.valid?
        assert_equal context.strip, @translation.context
    end

    test "first letter of context should be upcased before save" do
        context = "hagrid à dit bonjour à Harry"
        @translation.context = context
        @translation.save
        assert_equal @translation.context.capitalize, @translation.context
    end

    test "context should have at most 500 characters" do
        @translation.context = "a" * 501
        assert_not @translation.valid?
    end

    test "translation's support should exist" do
        @translation.support_id = 9999
        assert_not @translation.valid?
    end

    test "StatementInvalid error should be thrown when trying to delete a translation's support" do
        @translation.save
        assert_raises ActiveRecord::StatementInvalid do
            @translation.support.delete
        end
    end

    test "StatementInvalid error should be thrown if trying to delete a translation's writing" do
        @translation.save
        assert_raises ActiveRecord::StatementInvalid do
            @translation.sourceWriting.delete
        end
    end
end
