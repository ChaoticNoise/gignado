Rails.application.routes.draw do
  resources :events, :only => [:index] do
    resources :promotions, :only => [:new]
  end
  resources :gigs do
    collection do
      get 'sync'
      get 'async_grid'
    end
  end
  resources :rehearsals
  resources :promotions

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}
  resources :members do
    collection do
      get 'query'
    end
  end

  resources :errors, :only => [] do
    collection do
      get 'inactive'
    end
  end

  scope module: 'api' do
    namespace 'v1' do
      resources :promotions, only: [:index]
      resources :bots, only: [] do
        collection do
          post :slack
        end
      end
    end
  end

  match '/check(.json)' => 'status#check', :via => :get

  root to: "gigs#index"
end
