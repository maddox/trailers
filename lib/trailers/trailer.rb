module Trailers
  class Trailer
    attr_accessor :location_url, :urls, :post_date, :hd, :type, :exclusive, :source
    
    def initialize(options={})
      @post_date = Date.parse(options["postdate"]) if options["postdate"]
      @hd = options['hd']
      @type = options['type']
      @exclusive = options['exclusive']
      @location_url = options['url']
    end
    
    def hd?
      hd == true
    end
    
    def trailer_url(format)
      @urls ||= retrieve_trailers

      case format
      when "1080p"
        urls[format] ? urls[format] : trailer_url("720p")
      when "720p"
        urls[format] ? urls[format] : trailer_url("480p")
      when "480p"
        urls[format] ? urls[format] : trailer_url("large")
      when "large"
        urls[format] ? urls[format] : trailer_url("medium")
      when "medium"
        urls[format] ? urls[format] : trailer_url("small")
      when "small"
        urls[format] ? urls[format] : trailer_url("iphone")
      when "iphone"
        urls[format] ? urls[format] : nil
      end
      
    end
    
    private
    
    def retrieve_trailers
      found_urls = {}
      doc = Hpricot(open("http://www.apple.com" + location_url))
      doc = Hpricot(open("http://www.apple.com" + location_url + 'hd/')) unless doc.at(".large")
      
      found_urls['small'] = doc.at(".small")['href'] if doc.at(".small")
      found_urls['medium'] = doc.at(".medium")['href'] if doc.at(".medium")
      found_urls['large'] = doc.at(".large")['href'] if doc.at(".large")
      found_urls['480p'] = doc.at(".480p")['href'] if doc.at(".480p")
      found_urls['720p'] = doc.at(".720p")['href'] if doc.at(".720p")
      found_urls['1080p'] = doc.at(".1080p")['href'] if doc.at(".1080p")
      found_urls['iphone'] = get_iphone_trailer

      found_urls
    end
    
    def get_iphone_trailer
      redirect_doc = open("http://www.apple.com" + location_url.gsub('/trailers/', '/trailers/iphone/')).read
      if (redirect_doc =~ /<meta http-equiv="refresh" content="1; URL=([^"]+)">/)
        trailer_doc = Hpricot(open("http://www.apple.com#{$1}"))
      else
        trailer_doc = Hpricot(redirect_doc)
      end
      trailer_embed = (trailer_doc/"embed").first
      if (trailer_embed)
        return trailer_embed['href']
      else
        return nil
      end
    end
    
  end
end
