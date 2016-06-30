require 'nokogiri'
require 'open-uri'

class MapBuilder



  attr_accessor :link, :page_map, :page_name, :html
  def initialize(link)
    @link = link
    @page_map = {}
    @page_name
    @html
  end


  def build_map
    get_html
    # get page name
    # get page links
    # get static urls (img, video, etc.)
  end

  #get raw page html
  def get_html
    @html = Nokogiri::HTML(open(@link.url))
  end

  #use regex to take the link url and capture anything after the final / in the root domain name. Set that as the page name.
  def get_page_name
    page_name = @link.url.match(/\/\/\w*\.\w*\/(.*)/)[1]
    page_name.empty? ? @page_name = "root" : @page_name = page_name
  end


end
