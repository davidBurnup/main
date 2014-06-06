Worship::Application.routes.draw do
  resources :songs
  resources :user_song_preferences

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end