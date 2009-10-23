require 'test_helper'

class AppleTrailersTest < Test::Unit::TestCase
  
  context "ItmsTrailerSource" do
    setup do
      @itms = Trailers::ItmsTrailerSource.new
    end
    
    context "when searching for a movie" do
      setup do
        @movies = @itms.find_by_name('a nightmare on elm street')
      end
    
      should "return an array" do
        assert_equal Array, @movies.class
      end
      
      should "return movies" do
        assert_equal Trailers::Movie, @movies.first.class
      end
      
      context "the returned movie" do
        setup do
          @movie = @movies.first
        end
        
        should "have 2 trailer urls" do
          assert_equal 2, @movie.trailer.urls.keys.size
        end

        should "have an iphone url" do
          assert @movie.trailer.urls["iphone"]
        end

        should "have a large url" do
          assert @movie.trailer.urls["large"]
        end

      end

    end

    
  end
  
end
