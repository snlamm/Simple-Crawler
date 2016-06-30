Rails.application.routes.draw do

  get '/',          to: 'webmap#new'
  post 'webmap',    to: 'webmap#create'
end
