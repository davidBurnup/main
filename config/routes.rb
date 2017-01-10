Worship::Application.routes.draw do

  resources :posts

  resources :activities, only: [:destroy], controller: "socializables"

  resources :churches

  resources :comments

  get 'notifications/:id' => "notifications#show", as: 'notification'

  get 'fil' => "socializables#index", :as => "feeds"

  get 'fil/:id' => "socializables#show", as: "show_activity"

  get 'action' => "socializables#action", :as => "my_action"

  get 'aime(/:likable_type/:likable_id)' => "socializables#like", :as => "like"

  resources :teams

  post "recherche/chants" => "songs#index", :as => "songs_search"

  resources :chants, :controller => "songs", :as => "songs"

  resources :user_song_preferences

  root :to => "socializables#index"

  devise_for :users, :path => "utilisateurs", :path_names => {:sign_in => 'se-connecter', :sign_out => 'se-deconnecter', password: 'mot-de-passe', confirmation: 'confirmation', unlock: 'deverrouillage', registration: 'inscription', sign_up: 'nouvelle' }, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get 'utilisateurs/inscription/mot-de-passe' => "registrations#password", :as => "edit_current_password"
    put 'utilisateurs/inscription/mot-de-passe' => "registrations#update_password", :as => "update_current_password"

    get 'utilisateurs/inscription/parametres-generaux' => "registrations#instruments", :as => "instruments"
    put 'utilisateurs/inscription/parametres-generaux' => "registrations#update_instruments", :as => "update_instruments"

  end

  get "utilisateurs/en-cours" => "users#show", :as => "current_user"
  resources :users, :path => "utilisateurs" do
    member do
      get 'finaliser-mon-compte' => "users#unfinalized", as: "unfinalized"
    end
  end
  get "utilisateurs/:id/instruments(/:target)" => "users#instruments"
  post "reunions/new" => "meetings#new"
  resources :meetings, :path => "reunions"

  namespace :api do
    resources :notifications, only: [:index, :destroy, :update] do
      collection do
        get "/page/:page" => "notifications#index"
      end
    end
    resources :users, only: [:create, :update], path: 'utilisateurs'
    resources :churches, only: [:index, :create], path: 'eglises' do
      collection do
        get "/recherche/:search" => "churches#index"
      end
    end

    resources :instrument_preferences, path: "instruments"
  end
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
