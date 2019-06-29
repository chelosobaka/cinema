Rails.application.routes.draw do

  root "movies#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :movies, only: [:index, :show] do
    member do
      put "like" => "movies#upvote"
      put "unlike" => "movies#downvote"
    end
  end

  get 'favorite/:id' => "favorites#show", as: "favorite"
  delete 'favorite/:id' => "favorites#destroy"

  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"

end
