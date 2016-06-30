class Link

  attr_accessor :url, :was_crawled
  def initialize(url)
    @url = url
    @not_crawled = true
  end

end
