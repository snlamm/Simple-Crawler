Rails.application.routes.draw do

  get '/',          to: 'sitemaps#new'
  post 'sitemap',    to: 'sitemaps#create'
end
