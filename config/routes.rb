Rails.application.routes.draw do

  devise_for :users
  #devise_scope :user do
    #get '/users/sign_out' => 'devise/sessions#destroy'
  #end
  ActiveAdmin.routes(self)


  root "movies#index"
  resources :movies, only: [:index, :show] do
    member do
      put "like" => "movies#upvote"
      put "dislike" => "movies#downvote"
    end
  end

  get 'favorite/:id' => "favorites#show", as: "favorite"
  delete 'favorite/:id' => "favorites#destroy"

  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
end
