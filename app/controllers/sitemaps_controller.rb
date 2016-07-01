class SitemapsController < ApplicationController
  def new
  end

  def create
    @crawled_site = WebCrawlers.new("http://wiprodigital.com/")
    render :show
  end
end
