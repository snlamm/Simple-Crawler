Rails.application.routes.draw do

  #the route to sitemaps controller's create action
  get 'sitemap',  to: 'sitemaps#create'
end
