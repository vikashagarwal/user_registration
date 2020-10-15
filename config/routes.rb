Rails.application.routes.draw do

  resources :home, only: [:index, :new, :create, :edit, :update]

  root to: 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  match '*path' => redirect('/'), via: :get
end
