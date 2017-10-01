Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  #patch 'supports/archive/:id' => 'supports#archive', as: 'archive_support'

  resources :supports do
  	patch :archive, on: :member
    resources :translations
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
