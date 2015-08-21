Rails.application.routes.draw do
  devise_for :members

  devise_scope :member do
    root to: "devise/sessions#new"
  end
end
