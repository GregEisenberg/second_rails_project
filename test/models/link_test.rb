require "test_helper"


class LinkTest < ActiveSupport::TestCase
    test "invalid link - needs at least 5 chars in title" do
      link = User.first().links.new()

      link.title = "four"
      link.url = "at least five chars"

      result = link.save()
      assert_not(result)
    end

    test "valid link - needs at least 5 chars in title" do
      link = User.first().links.new()

      link.title = "five5"
      link.url = "at least five chars"

      result = link.save()
      assert(result)
    end

    test "invalid link - needs at least 5 chars in url" do
        link = User.first().links.new()

        link.title = "at least five chars"
        link.url = "four"

        result = link.save()
        assert_not(result)
    end

      test "valid link - needs at least 5 chars in url" do
        link = User.first().links.new()

        link.title = "at least five chars"
        link.url = "five5"

        result = link.save()
        assert(result)
    end
end
