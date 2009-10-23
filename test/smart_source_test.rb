require 'test_helper'

class SmartSourceTest < Test::Unit::TestCase
  
  context "SmartTrailerSource" do
    setup do
      @smart_source = Trailers::SmartTrailerSource.new
    end
    
    context "when searching for a theater movie" do
      setup do
        @movies = @smart_source.find_by_name("A Nightmare On Elm Street")
      end

      should "return an array" do
        assert_equal Array, @movies.class
      end

      should "return an array of movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    
    end

    context "when searching for an old movie" do
      setup do
        @movies = @smart_source.find_by_name("Die Hard")
      end

      should "return an array" do
        assert_equal Array, @movies.class
      end

      should "return an array of movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    
    end

  end
  
end
