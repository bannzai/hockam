Rails.application.routes.draw do
  get 'news', to: 'news#index'
  get 'news/:id', to: 'news#show'
  get 'inquiry', to: 'inquiry#form'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'
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
