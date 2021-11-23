Rails.application.routes.draw do
  #get 'users/show'を削除。下のusersとの重複回避のため。
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]do
     resource :favorites, only: [:create, :destroy]
     resources :post_comments, only: [:create, :destroy]
  end
    
  resources :users, only: [:show, :edit, :update, :index, :create]do
    resource :relationships, only: [:create, :destroy]
    get :follower, on: :member
    get :followed, on: :member
    get "search", to: "users#search"
  end
  
  get '/search', to: 'searches#search'
  resources :chats, only:[:show, :create]

  
end
