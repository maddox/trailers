require 'test_helper'

class TrailersTest < Test::Unit::TestCase
  
  context "SmartTrailerSource" do
    
    context "when searching for a theater movie" do
      setup do
        @smart_source = SmartTrailerSource.new
        @trailer = @smart_source.find_by_name("A Nightmare On Elm Street")
      end

      should "find the movie" do
        assert_equal 'A Nightmare On Elm Street', @trailer.name
      end
    
    end

    context "when searching for an old movie" do
      setup do
        @smart_source = SmartTrailerSource.new
        @trailer = @smart_source.find_by_name("Die Hard")
      end

      should "find the movie" do
        assert_equal 'Die Hard', @trailer.name
      end
    
    end

  end
  
end
