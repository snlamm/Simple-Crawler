class WebCrawlers
  attr_accessor :domain_root, :sitemap, :all_links
  def initialize(domain)
    @domain_root = Link.new(domain)
    @sitemap = {}
    @all_links = []
    @all_links << @domain_root
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
    @all_links.detect {|link| link.not_crawled}
  end

  def extract_link_map(next_link)
    webpage = MapBuilder.new(next_link)
    update_webcrawler(webpage)
  end

  def update_webcrawler(webpage)
    name = webpage.page_name
    map = webpage.page_map
    @sitemap[name] = map
    check_for_new_links(webpage.domain_links)
  end

  def check_for_new_links(domain_links)
    current_links = @all_links.map {|link| link.url}
    links_to_add = domain_links - current_links
    links_to_add.map do |link|
      add_link = Link.new(link)
      @all_links << add_link
    end
  end

end
