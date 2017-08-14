require 'test_helper'

class MediaTypeTest < ActiveSupport::TestCase

    def setup
        @media_type = MediaType.new(name:"Book")
    end

    test "should be valid" do
        assert @media_type.valid?
    end

    test "name should never be blank" do
        @media_type.name = "   "
        assert_not @media_type.valid?
    end

    test "name should at least have 2 characters" do
        @media_type.name = "a"
        assert_not @media_type.valid?
    end

    test "name should at most have 50 characters" do
        @media_type.name = "a" * 51
        assert_not @media_type.valid?
    end

    test "name should be trimmed before validation" do
        name = " Music "
        @media_type.name = name
        @media_type.valid?
        assert_equal name.strip, @media_type.name
    end

    test "name should be capitalized before save" do
        name = "course"
        @media_type.name = name
        @media_type.save
        assert_equal name.capitalize, @media_type.name
    end

end
