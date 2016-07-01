class SitemapsController < ApplicationController
  def new
  end

  # this controller action calls on the WebCrawlers class, found in app/services. This class will return all the data on the sitemap formatted in an ordered mixture of hashes and arrays.
  # The data is then rendered by the template in views/sitemaps/show.html.erb
  def create
    @crawled_site = WebCrawlers.new("http://wiprodigital.com/")
    render :show
  end
end
