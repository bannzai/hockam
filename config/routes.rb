Rails.application.routes.draw do
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
end
