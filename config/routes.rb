Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  resources :supports do
  	patch :archive, on: :member
    resources :translations
    resources :reviews, only: [:create]
    resources :sublists, only: [:create, :new]
  end

  resources :reviews, :only => [] do
    resources :answers, only: [:new, :create]
  end

  get '/english_to_french/:phrase', to: 'english_to_french_dictionary#index'
  get '/french_to_english/:phrase', to: 'french_to_english_dictionary#index'
  get '/french_to_german/:phrase', to: 'french_to_german_dictionary#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
