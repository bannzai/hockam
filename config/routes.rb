Rails.application.routes.draw do
  get 'pages/about'
  root 'pages#home'
end
