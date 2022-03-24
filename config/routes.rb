Rails.application.routes.draw do
  resources :reviews
  resources :channels do
    resource :channel_user
    resources :messages
  end
  devise_for :users
  ActiveAdmin.routes(self)
  root 'movies#index'
  resources :movies, only: %i[index show] do
    resources :reviews
    member do
      put 'like' => 'movies#upvote'
      put 'dislike' => 'movies#downvote'
    end
  end
  get 'favorite/:id' => 'favorites#show', as: 'favorite'
  delete 'favorite/:id' => 'favorites#destroy'
  post 'line_items' => 'line_items#create'
  get 'line_items/:id' => 'line_items#show', as: 'line_item'
  delete 'line_items/:id' => 'line_items#destroy'
end
