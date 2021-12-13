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
  end

  get '/search', to: 'searches#search'
  resources :groups, only: [:index, :new, :create, :show, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

end
