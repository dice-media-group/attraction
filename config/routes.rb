require 'sidekiq/web'


Rails.application.routes.draw do
  get 'blog/index'
  resources :posts
  namespace :admin do
    resources :posts
    resources :users
    resources :announcements
    resources :notifications
    resources :services

    root to: "users#index"
  end
  get '/privacy',   to: 'home#privacy'
  get '/terms',     to: 'home#terms'
  get '/work',      to: 'home#work'
  get '/about',     to: 'home#about'
  get '/about-us',  to: 'home#about'
  get '/about_us',  to: 'home#about'
  get '/contact',   to: 'home#contact'
  get '/careers',   to: 'home#careers'
  get '/index',     to: 'home#index'
  get '/pricing',   to: 'home#pricing'
  get '/blog',      to: 'home#blog'
  get '/contact',   to: 'home#contact'
  get '/form-2',    to: 'home#form_2'
  get '/form-3',    to: 'home#form_3'
  get '/single_article',    to: 'home#single_article'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
