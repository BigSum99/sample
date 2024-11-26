Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'users/account', to: 'users/registrations#show', as: 'user_account'
  end

  namespace :users do
    get 'profile', to: 'profiles#show', as: 'profile'
    get 'profile/edit', to: 'profiles#edit', as: 'edit_profile'
    patch 'profile', to: 'profiles#update'
  end

  resources :rooms do
    collection do
      get 'my_rooms', to: 'rooms#my_rooms'
    end
    resources :reservations, only: [:new, :create]
  end

  get 'reservations/confirm', to: 'reservations#confirm'
  post 'reservations/confirm', to: 'reservations#confirm'
  post 'reservations/complete', to: 'reservations#complete'

  resources :reservations, only: [:index, :edit, :update, :destroy]

  root to: 'home#index'
end
