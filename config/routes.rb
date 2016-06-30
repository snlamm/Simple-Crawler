Rails.application.routes.draw do

  get '/',          to: 'sitemaps#new'
  post 'sitemap',   to: 'sitemaps#create'

  #temporary route for testing purposes
  get 'sitemap',  to: 'sitemaps#create'
end
