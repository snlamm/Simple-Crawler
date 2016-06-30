class SitemapsController < ApplicationController
  def new
  end

  def create
    #hard-code wipro domain for testing purposes
    # webcrawler = WebCrawlers.new("http://wiprodigital.com/")
    l = Link.new("http://wiprodigital.com/")
    m = MapBuilder.new(l)
    binding.pry
    #get_domain name as params
    #make new webcrawler class instance using service
    #get sitemap
    #render sitemap
  end
end
