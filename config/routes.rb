Rails.application.routes.draw do
  get 'goods/minne'
  get 'goods/suzuri'
  get 'goods/stores'
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
end
