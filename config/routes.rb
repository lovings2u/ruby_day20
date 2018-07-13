Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/ahctaw', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root 'movies#index'
  
  resources :movies do
    member do
      post '/comments' => 'movies#create_comment'
    end
    collection do
      delete '/comments/:comment_id' => 'movies#destroy_comment'
      patch '/comments/:comment_id' => 'movies#update_comment'
      get '/search_movie' => 'movies#search_movie'
    end
    # collection do
    #   get '/test' => 'movies#test_collection'
    # end
  end
  
  post '/uploads' => 'movies#upload_image'
  
  get '/likes/:movie_id' => 'movies#like_movie'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
