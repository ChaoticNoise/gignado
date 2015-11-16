Rails.application.routes.draw do
  resources :gigs, :only => [:show, :new, :create, :edit, :update, :destroy]
  resources :events, :only => [:index, :destroy]

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}
  resources :members, :only => [:index, :edit, :update]

  resources :errors, :only => [] do
    collection do
      get 'inactive'
    end
  end

  scope module: 'api' do
    namespace 'v1' do
      resources :bots, only: [] do
        collection do
          post :slack
        end
      end
    end
  end

  match '/check(.json)' => 'status#check', :via => :get

  root to: "events#index"
end
