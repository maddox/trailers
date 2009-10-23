module Trailers
  class Movie
    attr_accessor :title, :poster_url, :directors, :genres, :mpaa_rating, :studio, :actors, :release_date, :trailer
    
    def initialize(options={})
      @title = options["title"]
      @directors = options["directors"].split(', ') if options["directors"]
      @genres = options["genre"]
      @mpaa_rating = options["rating"]
      @studio = options["studio"]
      @actors = options["actors"]
      @release_date = Date.parse(options["releasedate"]) if options["releasedate"]
      
      # transform poster_url into the larger one IF its there
      if options["poster"]
        small_poster_url = options["poster"]
        small_filename = small_poster_url.split('/').last
        large_url = small_poster_url.gsub('trailers', 'moviesxml/s').gsub('/images/', '/posters/')
        large_filename = small_filename.gsub(/_(\d+).jpg/, "_l" + '\1' + ".jpg")
        @poster_url = large_url.gsub(small_filename, large_filename)
      
        # do trailer
        trailer_hash = options['trailers'][0]
        # inject the url if its not already there, this happens on search results
        trailer_hash['url'] = options['location'] unless trailer_hash['url']
        # make trailer
        @trailer = Trailer.new(trailer_hash)
      end
    end
    
    
    
    private
    
  end
end
