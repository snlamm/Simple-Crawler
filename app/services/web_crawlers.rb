class WebCrawlers
  attr_accessor :domain_root
  def initialize(domain)
    @domain_root = Link.new(domain)
    @webmap = {}
    @all_links = []
    @ll_links << @domain_root
    recursive_build
  end

  #get next uncrawled links
  #return if there is no uncrawled link
  #get sitemap info for that page
  # recursive build
  def recursive_build
    next_link = find_uncrawled
    return unless next_link
    extract_link_map(next_link)
    recursive_build
  end

  def find_uncrawled
    #find first uncrawled link
  end

  def extract_link_map(next_link)
    #make a mapbuilder
    #update webcrawler class with mapbuilder info
  end

end

class Link

  attr_accessor :url, :was_crawled
  def initialize(url)
    @url = url
    @not_crawled = true
  end

end
