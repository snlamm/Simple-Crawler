class WebCrawlers
  attr_accessor :domain_root
  def initialize(domain)
    @domain_root = Link.new(domain)
  end

  def recursive_build
    #get next uncrawled links
    #return if there is no uncrawled link
    #get sitemap info for that page
    # recursive build
  end

end

class Link

  attr_accessor :url, :was_crawled
  def initialize(url)
    @url = url
    @not_crawled = true
  end

end
