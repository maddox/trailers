require 'test_helper'

class MovieTest < Test::Unit::TestCase
  
  context "Movie" do
    
    context "when requesting a trailer" do
      setup do
        @ats = Trailers::AppleTrailerSource.new
        @movies = @ats.get_just_added
        @movie = @ats.get_just_added.first
      end
      
      should "have a title" do
        assert_not_nil @movie.title
      end
    
      should "have a poster" do
        assert_not_nil @movie.poster_url
      end
    
      should "have trailers" do
        assert_not_nil @movie.trailer
      end
    end
    
  end
  
end
