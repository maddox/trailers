module Trailers
  class AppleTrailerSource < TrailerSource
    include HTTParty
    base_uri 'www.apple.com'
    format :json

    def initialize
    end
    
    # new Trailers.PosterSection('justadded', '/trailers/home/feeds/just_added.json'),
    # new Trailers.PosterSection('exclusive', '/trailers/home/feeds/exclusive.json'),
    # new Trailers.PosterSection('justhd', '/trailers/home/feeds/just_hd.json'),
    # new Trailers.PosterSection('mostpopular', '/trailers/home/feeds/most_pop.json'),
    # new Trailers.GenreSection('genres', '/trailers/home/feeds/genres.json'),
    # new Trailers.StudioSection('moviestudios', '/trailers/home/feeds/studios.json'),
    # new Trailers.SearchSection('quickfind', 'http://www.apple.com/trailers/home/scripts/quickfind.php?callback=searchCallback&q=')];
    
    def get_just_added
      response = self.class.get("/trailers/home/feeds/just_added.json")
      response.map{|m| Movie.new(m)}
    end

    def get_exclusive
      response = self.class.get("/trailers/home/feeds/exclusive.json")
      response.map{|m| Movie.new(m)}
    end

    def get_just_hd
      response = self.class.get("/trailers/home/feeds/just_hd.json")
      response.map{|m| Movie.new(m)}
    end

    def get_most_popular
      response = self.class.get("/trailers/home/feeds/most_pop.json")
      response.map{|m| Movie.new(m)}
    end

    def find_by_name(name)
      response = self.class.get("/trailers/home/scripts/quickfind.php", :query => {:q => name})
      response['results'].map{|m| Movie.new(m)}
    end
  end
end
