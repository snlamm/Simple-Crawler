# MapBuilder uses nokogiri and open-uri to get the data our app needs from each web page. Nokogiri is used for web scraping, while open-uri allows us to easily make http requests through the 'open' method.
# Once the html from a page is obtained, MapBuilder stores the page name to use as a title (ex. 'wiprodigital.com/about' becomes 'about'), and creates a page map (@page_map) with the links, images, and iframes on the page. The methods that obtain each of these elements are simple and @page_map is easily expanded, which means we can easily add more categories to the map.

require 'nokogiri'
require 'open-uri'

class MapBuilder

  attr_accessor :link, :page_map, :page_name, :domain_links, :html
  def initialize(link)
    @link = link
    @page_map = {}
    @page_name
    @domain_links = []
    @html
    build_map
  end

# called on initialization, build_map is the runner for the rest of the instance methods in this object. It is easily expanded. To add the text of all <p> elements to the sitemap, for example, I'd merely add a get_paragraphs method. The final result is that MapBuilder will have all the data we want from the page in its @page_map variable, which will then be accessible to the main WebCrawler object in app/services/web_crawlers.rb. The begin/rescue method is used to avoid links that are broken or cannot be crawled, such as pdfs. 
  def build_map
    begin
      get_html
    rescue
      :error
      @link.not_crawled = false
    else
      get_page_name
      get_images
      get_iframes
      get_page_links
    end
  end

  #get page's raw html
  def get_html
    @html = Nokogiri::HTML(open(@link.url))
    @link.not_crawled = false
  end

  #use regex to take the page's and capture anything after the final / in the root domain name. That capture group is then set as the @page_name. Thus, wiprodigital.com/about becomes 'about'
  def get_page_name
    page_name = @link.url.match(/\/\/\w*\.\w*\/(.*)/)[1]
    page_name.empty? ? @page_name = "root" : @page_name = page_name
  end

#adds images and iframes to @page_map
  def get_static_urls
    get_images
    get_iframes
  end

  def get_images
    img_tags = @html.css('img')
    src_urls = img_tags.map {|img| img.attribute('src').value}
    @page_map[:images] = src_urls
  end

  def get_iframes
    iframe_tags = @html.css('iframe')
    src_urls = iframe_tags.map {|iframe| iframe.attribute('src').value}
    @page_map[:iframes] = src_urls
  end

# this method goes through every <a> tag and discounts any that do not have an href. It then passes the remaining urls to handle_page_links for formatting.
  def get_page_links
    a_tags = @html.css('a')
    href_urls = a_tags.map do |a_tag|
      if a_tag.attribute('href')
        value = a_tag.attribute('href').value
        value if value != "#"
      end
    end
    href_urls.compact!
    handle_page_links(href_urls)
  end

# formats page links when necessary by adding the domain if the link is for wipro or deleting the link if it is merely a redirect to a different part of the same page. The links are then added to @page_map
  def handle_page_links(urls)
    external_links = []
    urls.map! do |url|
      if url[0] == "/"
        full_url = "http://wiprodigital.com" + url
        @domain_links << full_url
        full_url
      elsif url.match(/http\:\/\/wiprodigital.com/)
        @domain_links << url
        url
      elsif url[0] == "#"
        nil
      else
        url
      end
    end
    @domain_links.uniq!
    @page_map[:page_links] = urls.compact.uniq
  end

end
