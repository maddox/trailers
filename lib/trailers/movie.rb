module Trailers
  class Movie
    attr_accessor :title, :poster_url, :directors, :genres, :mpaa_rating, :studio, :actors, :release_date, :trailer
    
    def initialize(options={})
      @title = options["title"]
      @poster_url = options["poster"]
      @directors = options["directors"].split(', ') if options["directors"]
      @genres = options["genre"]
      @mpaa_rating = options["rating"]
      @studio = options["studio"]
      @actors = options["actors"]
      @release_date = Date.parse(options["releasedate"]) if options["releasedate"]
      
      # do trailer
      trailer_hash = options['trailers'][0]
      # inject the url if its not already there, this happens on search results
      trailer_hash['url'] = options['location'] unless trailer_hash['url']
      # make trailer
      @trailer = Trailer.new(trailer_hash)
    end
    
    
    
    private
    
  end
end
