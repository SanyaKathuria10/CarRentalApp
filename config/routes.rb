Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'users#logged_in'
      resources :users do
        collection do
          post :login_verify
          post :create_admin
          get  :logged_in
          get  :list_users
          get  :list_admins
          get  :login
        end
        member do
          get :update_profile
          get :book_car
          get :current_reservations
          get :checkout_history
          get :return_car
          get :checkout
          get :cancel_reservation
        end
      end

    resources :cars do
      collection do
        post  :get_availableCars
      end
    end

    resources :reservations
  end

