Rails.application.routes.draw do
  resources :events, :only => [:index]
  resources :gigs, :only => [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'sync'
      get 'async_grid'
    end
  end

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks"}
  resources :members, :only => [:index, :edit, :update] do
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
