Rails.application.routes.draw do
  devise_for :users
  root to:'homes#top'
  get 'home/about' => 'homes#about'
  get 'books/sort' => 'books#sort'
  get 'users/:id/sort' => 'users#sort', as: 'users_sort'
  resources :books do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end
  post 'users/:id' => 'users#search'
  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'search' => 'search#search', as: 'search'
  get 'search_category' => 'search#search_category', as: 'search_category'
  resources :messages, only:[:create]
  resources :rooms, only:[:create, :show, :index]
  resources :groups do
    resource :group_users, only:[:create, :destroy]
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end
end
