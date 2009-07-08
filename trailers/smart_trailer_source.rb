class SmartTrailerSource < TrailerSource
  def initialize
    @apple = AppleTrailerSource.new
    @itms = ItmsTrailerSource.new
  end

  def find_by_name(name)
    trailer = @apple.find_by_name(name)
    if (!trailer)
      trailer = @itms.find_by_name(name)
    end
    trailer
  end
end
