require 'test_helper'

class TrailerTest < Test::Unit::TestCase
  
  context "Trailer" do
    setup do
      @ats = Trailers::AppleTrailerSource.new
      @movies = @ats.find_by_name('transylmania')
      
    end
    
    context "when requesting a trailer from a normal page" do
      setup do
        @trailer = @movies.first.trailer
      end
    
      should "return an iphone trailer url" do
        assert_match(/320i.mov/, @trailer.trailer_url('iphone'))
      end
          
      should "return a 480p trailer url" do
        assert_match(/480p.mov/, @trailer.trailer_url('480p'))
      end
          
      should "return a 720p trailer url" do
        assert_match(/720p.mov/, @trailer.trailer_url('720p'))
      end
          
      should "return a 1080p trailer url" do
        assert_match(/1080p.mov/, @trailer.trailer_url('1080p'))
      end
      
      should "return a small trailer url" do
        assert_match(/320.mov/, @trailer.trailer_url('small'))
      end
          
      should "return a medium trailer url" do
        assert_match(/480.mov/, @trailer.trailer_url('medium'))
      end
          
      should "return a large trailer url" do
        assert_match(/640.mov/, @trailer.trailer_url('large'))
      end
    end



    context "when requested size isn't actually there" do
      setup do
        @trailer = Trailers::Trailer.new
        @trailer.urls = {"iphone" => 'http://iphone.mov'}
      end
    
      should "travel all the way down to the next highest quality" do
        assert_equal "http://iphone.mov", @trailer.trailer_url('1080p')
      end
    end

    # context "when requesting a trailer from a specialty page" do
    #   setup do
    #     @trailer = @movies.first.trailer
    #   end
    # 
    #   should "return a 480p trailer url" do
    #     assert_match(/480p.mov/, @trailer.trailer_url('480p'))
    #   end
    # 
    #   should "return a 720p trailer url" do
    #     assert_match(/720p.mov/, @trailer.trailer_url('720p'))
    #   end
    # 
    #   should "return a 1080p trailer url" do
    #     assert_match(/1080p.mov/, @trailer.trailer_url('1080p'))
    #   end
    # end




    
  end
end
