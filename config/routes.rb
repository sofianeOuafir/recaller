Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  #patch 'supports/archive/:id' => 'supports#archive', as: 'archive_support'

  resources :supports do
  	patch :archive, on: :member
    resources :translations
    resources :reviews, only: [:create]
  end

  resources :reviews, :only => [] do
    resources :answers, only: [:new, :create]
  end



  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
