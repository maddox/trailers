module Trailers
  class SmartTrailerSource < TrailerSource
    def initialize
      @amt = AppleTrailerSource.new
      @itms = ItmsTrailerSource.new
    end

    def find_by_name(name)
      movies = @amt.find_by_name(name)
      if movies
        movies
      else
        @itms.find_by_name(name)
      end
    end
    
  end
end