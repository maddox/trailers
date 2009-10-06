class ItmsTrailerSource < TrailerSource
  def find_by_name(name)
    results = Plist.parse_xml(open("http://ax.search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?submit=edit&media=all&term=#{CGI.escape(name)}",
      {
        'User-Agent' => 'iTunes-iPhone/3.0 (3)',
        'X-Apple-Store-Front' => '143441-1,2',
        'Host' => 'ax.search.itunes.apple.com',
        'X-Apple-Connection-Type' => 'WiFi',
        'X-Apple-Client-Application' => 'WiFi-Music'
      }
    ).read)

    trailer = nil
    items = results['items']
    if (items)
      matching_item = items.select { |item| item['media-type'] == 'video' && item['url-page-type'] == 'movie' && item['type'] == 'link' && item['title'].casecmp(name) == 0 }.first
      if (matching_item)
        movie_html = Nokogiri::HTML(open(matching_item['url'],
          {
            'User-Agent' => 'iTunes-iPhone/3.0 (3)',
            'X-Apple-Store-Front' => '143441-1,2',
            'Host' => 'ax.itunes.apple.com',
            'X-Apple-Connection-Type' => 'WiFi',
            'X-Apple-Client-Application' => 'WiFi-Music'
          }
        ).read)

        preview_button = movie_html.css('.preview-button.video').first
        if (preview_button)
          trailer = Trailer.new
          trailer.name = name
          trailer.url = preview_button['preview-url']
          trailer.source = 'itms'
        end
      end
    end

    trailer
  end
end
