class Link

  attr_accessor :url, :not_crawled
  def initialize(url)
    @url = url
    @not_crawled = true
  end

end
