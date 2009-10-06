module Trailers
  class SmartTrailerSource < TrailerSource
    def initialize
      @apple = AppleTrailerSource.new
      @itms = ItmsTrailerSource.new
    end

    def find_by_name(name)
      movie = @apple.find_by_name(name).first
      trailer_url = movie.trailer.trailer_url('iphone') if movie.title =~ /^#{name}$/i
      if (!trailer_url)
        trailer_url = @itms.find_by_name(name).trailer_url('iphone')
      end
      trailer_url
    end
  end
end