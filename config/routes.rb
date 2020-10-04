Rails.application.routes.draw do
  get 'news', to: 'news#index'
  get 'news/:id', to: 'news#show'
  namespace :admin do
    resources :suzuri_goods
    resources :minne_goods
    resources :news

    root to: "suzuri_goods#index"
  end
  get 'goods/minne'
  get 'goods/suzuri'
  get 'goods/stores'
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
end
