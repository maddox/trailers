class AppleTrailerSource < TrailerSource
  def initialize
    @trailers = {}
    JSON.parse(open('http://www.apple.com/trailers/iphone/home/feeds/studios.json').read).each do |movie|
      trailer = Trailer.new
      trailer.name = movie['title']
      trailer.processed = false
      trailer.url = "http://www.apple.com#{movie['trailers'][0]['url']}"
      trailer.source = 'apple'
      @trailers[trailer.name.downcase] = trailer
    end
  end

  def find_by_name(name)
    trailer = @trailers[name.downcase]
    if (trailer && !trailer.processed)
      redirect_doc = open(trailer.url).read
      if (redirect_doc =~ /<meta http-equiv="refresh" content="1; URL=([^"]+)">/)
        trailer_doc = Hpricot(open("http://www.apple.com#{$1}"))
      else
        trailer_doc = Hpricot(redirect_doc)
      end
      trailer_embed = (trailer_doc/"embed").first
      if (trailer_embed)
        trailer.url = trailer_embed['href']
        trailer.processed = true
      else
        trailer = nil
      end
    end
    trailer
  end
end
