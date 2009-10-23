require 'test_helper'

class AppleTrailersTest < Test::Unit::TestCase
  
  context "AppleTrailerSource" do
    setup do
      @ats = Trailers::AppleTrailerSource.new
    end
    
    context "when searching for a movie" do
      setup do
        @movies = @ats.find_by_name('a nightmare on elm street')
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
      
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    end

    context "when browsing just added movies" do
      setup do
        @movies = @ats.get_just_added
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
    
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    end
    
    context "when browsing exclusive movies" do
      setup do
        @movies = @ats.get_exclusive
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
    
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    end
    
    context "when browsing just hd movies" do
      setup do
        @movies = @ats.get_just_hd
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
    
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    end
    
    context "when browsing most popular movies" do
      setup do
        @movies = @ats.get_most_popular
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
    
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
    end
    
  end
  
end
