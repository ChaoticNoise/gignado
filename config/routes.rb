Rails.application.routes.draw do
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}

  devise_scope :member do
    root to: "devise/sessions#new"
  end
end
