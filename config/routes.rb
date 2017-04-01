Rails.application.routes.draw do
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'notifications/:id/link_through', to: 'notifications#link_through',
      as: :link_through
  get :notifications, to: 'notifications#index'
  get 'toggle_notification/:id', to: 'notifications#toggle_read',
      as: :toggle_notification

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'browse', to: 'posts#browse', as: :posts_browse

  # This allows for routes like '/kris'. In controller there will be
  # params[:name] = 'kris'. Beware though!!! /posts also will be
  # routed to profiles controller !!!
  get ':name', to: 'profiles#show', as: :profile
  get ':name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':name/edit', to: 'profiles#update', as: :update_profile

  root 'posts#index'
  resources :posts do
    resources :comments
  end
  resources :comments, only: [:destroy]

  # Voting system:
  patch ':id/like', to: 'posts#like', as: :like_post
  patch ':id/unlike', to: 'posts#unlike', as: :unlike_post
end
