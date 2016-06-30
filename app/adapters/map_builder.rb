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

  def get_html
    @html = Nokogiri::HTML(open(@link))
  end

end
