Rails.application.routes.draw do
  resources :gigs, :only => [:show, :new, :create, :edit, :update, :destroy]
  resources :events, :only => [:index]

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}
  resources :members, :only => [:index, :edit, :update]

  resources :errors, :only => [] do
    collection do
      get 'inactive'
    end
  end

  root to: "events#index"
end
