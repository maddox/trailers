class AppleTrailerSource < TrailerSource
  def initialize
    @trailers = {}
    Nokogiri::XML(open('http://www.apple.com/trailers/home/xml/current.xml')).xpath('//records/movieinfo/info').each do |movie|
      trailer = Trailer.new
      trailer.name = movie.at('title').content
      trailer.url = movie.xpath('//preview/large').first.content
      trailer.source = 'apple'
      @trailers[trailer.name.downcase] = trailer
    end
  end

  def find_by_name(name)
    return @trailers[name.downcase]
  end
end
