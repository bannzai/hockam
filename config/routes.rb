Rails.application.routes.draw do
  get 'pages/about'
  root 'application#hello'
end
