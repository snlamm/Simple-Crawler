  # The overall responsibility of this class is to store the sitemap, store page links, and to make sure the program runs until all pages have been visited.
  # This class is created with a root url, in this case http://wiprodigital.com/, and stores:
  # First, the sitemap (@sitemap), which will be enlarged continuously as the crawler iterates through the wipro website.
  # Second, an array (@all_links), that will be filled with wipro page links, which are stored in the form of Link objects. This array keeps track of wipro pages the crawler still needs to visit, as well as those it has visited already.
  # The advatange of Link objects is that we can associate a boolean instance variable to them (see link.rb), change it once the page has been crawled, and use that to tell the crawler not to crawl it again.

class WebCrawlers
  attr_accessor :domain_root, :sitemap, :all_links
  def initialize(domain)
    @domain_root = Link.new(domain)
    @sitemap = {}
    @all_links = []
    @all_links << @domain_root
    recursive_build
  end

  #the recursive_build method, called on creation of the webcrawler object, uses recursion to visit every page of the website. It starts with the root url (added on initialization to @all_links). When a page is visted, the wipro links on that page are added to @all_links and the @sitemap is updated with the page's data.
  # Once a page is visited, the boolean value of its Link object is changed so that the page will not revisited (see find_uncrawled below). The recursion ends once there are no more links left with the proper boolean value.
  # one tradeoff with using this method is that all the pages are scraped in one big process, which is relatively slow. Another way of doing this might be, for example, to implement lazy loading.
  def recursive_build
    next_link = find_uncrawled
    return unless next_link
    extract_link_map(next_link)
    recursive_build
  end

# returns the first Link object in the @all_links array that has @not_crawled set to true. This prevents repeated crawling. Once the Link object's url has been crawled, the @not_crawled switches to false
  def find_uncrawled
    @all_links.detect {|link| link.not_crawled}
  end

# this method calls on the MapBuilder object (see app/adapters/map_builder.rb), which scrapes the web page and formats the data. The object returns a hash/array mix with keys such as :links, :images, and :videos and values of the data, in array form, associated with each key. Mapbuilder will be run for each page that is crawled.
  def extract_link_map(next_link)
    webpage = MapBuilder.new(next_link, @domain_root.url)
    update_webcrawler(webpage) unless webpage == :error
  end

# this method updates the sitemap with the data returned by MapBuiler
  def update_webcrawler(webpage)
    name = webpage.page_name
    map = webpage.page_map
    @sitemap[name] = map
    check_for_new_links(webpage.domain_links)
  end

# this method seaches through all the links returned by MapBuilder that are associated with wipro and checks each one to see if it is in @all_links. If not, then a new Link object is created with that link as its @url, and the Link object is added to @all_links to be crawled.
  def check_for_new_links(domain_links)
    current_links = @all_links.map {|link| link.url}
    links_to_add = domain_links - current_links
    links_to_add.map do |link|
      add_link = Link.new(link)
      @all_links << add_link
    end
  end

end
