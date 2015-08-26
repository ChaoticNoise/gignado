Rails.application.routes.draw do
  resources :events, :only => [:index]
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}

  root to: "events#index"
end
