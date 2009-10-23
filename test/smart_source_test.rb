require 'test_helper'

class SmartSourceTest < Test::Unit::TestCase
  
  context "SmartTrailerSource" do
    setup do
      @smart_source = Trailers::SmartTrailerSource.new
    end
    
    context "when searching for a theater movie" do
      setup do
        @trailer_url = @smart_source.find_by_name("A Nightmare On Elm Street")
      end

      should "find the movie" do
        assert_match(/http/, @trailer_url)
      end
    
    end

    context "when searching for an old movie" do
      setup do
        @trailer_url = @smart_source.find_by_name("Die Hard")
      end

      should "find the movie" do
        assert_match(/http/, @trailer_url)
      end
    
    end

  end
  
end
