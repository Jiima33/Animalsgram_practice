Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root to:'homes#top'
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end 
  
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :notifications, only: [:index] do
    patch :checked, on: :member
  end
  get 'homes/about' => 'homes#about', as: 'about'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
