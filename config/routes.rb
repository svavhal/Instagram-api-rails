InstagramFeedsRails::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get 'posts/index'
  root 'posts#dashboard'
  resources :tags
end
