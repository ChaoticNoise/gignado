Rails.application.routes.draw do
  resources :gigs, :only => [:show, :new, :create, :edit, :update, :destroy]
  resources :events, :only => [:index]
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}

  root to: "events#index"
end
