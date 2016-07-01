class Link
  # each link has a string url and a boolean value used to tell the crawler that it has/has-not already visited that page. This way, the web crawler avoids re-crawling pages
  attr_accessor :url, :not_crawled
  def initialize(url)
    @url = url
    @not_crawled = true
  end

end
