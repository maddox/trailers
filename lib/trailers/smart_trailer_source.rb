module Trailers
  class SmartTrailerSource < TrailerSource
    def initialize
      @amt = AppleTrailerSource.new
      @itms = ItmsTrailerSource.new
    end

    def find_by_name(name)
      movie = @amt.find_by_name(name).first
      if movie
        trailer_url = movie.trailer.trailer_url('iphone') if movie.title =~ /^#{name}$/i
      else
        trailer_url = @itms.find_by_name(name).trailer_url('iphone')
      end
      trailer_url
    end
  end
end