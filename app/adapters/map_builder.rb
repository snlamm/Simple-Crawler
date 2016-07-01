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
  end


  def build_map
    get_html
    get_page_name
    get_images
    get_iframes
    # get page links
    # get static urls (img, video, etc.)
  end

  #get raw page html
  def get_html
    @html = Nokogiri::HTML(open(@link.url))
    @link.not_crawled = false
  end

  #use regex to take the link url and capture anything after the final / in the root domain name. Set that as the page name.
  def get_page_name
    page_name = @link.url.match(/\/\/\w*\.\w*\/(.*)/)[1]
    page_name.empty? ? @page_name = "root" : @page_name = page_name
  end

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

  def get_page_links
    a_tags = @html.css('a')
    href_urls = a_tags.map do |a_tag|
      if a_tag.attribute('href')
        value = a_tag.attribute('href').value
        value if value != "#"
      end
    end
    href_urls.compact
  end

end
