Worship::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "application#main_fallback"

  resources :posts, path: 'publications'

  resources :activities, only: [:index], path: "fil"#, only: [:destroy], controller: "socializables"

  resources :pages, path: "pages"

  resources :comments

  get 'utilisateurs/se-connecter' => "application#main_fallback"

  get 'notifications/:id' => "notifications#show", as: 'notification'

  # get 'fil' => "socializables#index", :as => "feeds"
  #
  # get 'fil/:id' => "socializables#show", as: "show_activity"

  get 'action' => "socializables#action", :as => "my_action"

  get 'aime(/:likable_type/:likable_id)' => "socializables#like", :as => "like"

  resources :teams

  post "recherche/chants" => "songs#index", :as => "songs_search"

  resources :chants, :controller => "songs", :as => "songs"

  resources :user_song_preferences

  devise_for :users, :path => "utilisateurs", :path_names => {:sign_in => 'se-connecter', :sign_out => 'se-deconnecter', password: 'mot-de-passe', confirmation: 'confirmation', unlock: 'deverrouillage', registration: 'inscription', sign_up: 'nouvelle' }, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get 'utilisateurs/inscription/mot-de-passe' => "registrations#password", :as => "edit_current_password"
    put 'utilisateurs/inscription/mot-de-passe' => "registrations#update_password", :as => "update_current_password"

    get 'utilisateurs/inscription/parametres-generaux' => "registrations#instruments", :as => "instruments"
    put 'utilisateurs/inscription/parametres-generaux' => "registrations#update_instruments", :as => "update_instruments"

  end

  get "utilisateurs/en-cours" => "users#show", :as => "current_user"
  resources :users, :path => "utilisateurs" do
    # member do
    #   get 'finaliser-mon-compte' => "users#unfinalized", as: "unfinalized"
    # end
  end
  get "utilisateurs/:id/instruments(/:target)" => "users#instruments"
  post "reunions/new" => "meetings#new"
  resources :meetings, :path => "reunions"

  namespace :api do

    get "main" => "api#main"

    resources :notifications, only: [:index, :destroy, :update] do
      collection do
        get "/page/:page" => "notifications#index"
      end
    end

    get "utilisateurs/courant" => "users#current", as: :current_user

    resources :medias, only: [:create, :destroy]

    resources :users, only: [:create, :update, :show], path: 'utilisateurs' do
      member do
        put 'aime/:activity_id' => "users#toggle_like", :as => "toggle_like"
        post "push" => "users#push_subscribe"
        # FIXME : change post for delete method once we found a way to send endpoint (which is an URL) via the URL param
        post "push/unsubscribe" => "users#push_unsubscribe"
      end
    end

    devise_scope :user do
      post "sessions/se-connecter" => "sessions#create", as: "sessions"
    end

    resources :pages, only: [:index, :create, :show], path: 'pages' do
      collection do
        get "/recherche/:search" => "pages#index"
      end
    end

    resources :instrument_preferences, path: "instruments"
    resources :activities, path: "activites" do
      collection do
        get "/sur/:recipient_type/:recipient_id(/page/:page)" => "activities#index"
        get "/page/:page" => "activities#index"
      end
      resources :comments, path: "commentaires", controller: 'activities/comments'
    end
    resources :posts, path: 'publications', only: [:show, :create, :update, :destroy]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
