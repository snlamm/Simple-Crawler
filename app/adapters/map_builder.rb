require 'nokogiri'
require 'open-uri'

class MapBuilder

  # get html from link url
  # get page name
  # get page links
  # get static urls (img, video, etc.)

  attr_accessor :link
  def initialize(link)
    @link = link
  end

  def get_html
    html = Nokogiri::HTML(open(@link))
  end

end
