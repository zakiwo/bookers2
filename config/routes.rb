Rails.application.routes.draw do
  devise_for :users
  root to:'homes#top'
  get 'home/about' => 'homes#about'
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
  get 'sort_by_evaluation' => 'sortings#sort_by_evaluation', as: 'sort_by_evaluation'
  get 'sort_by_updated_at' => 'sortings#sort_by_updated_at', as: 'sort_by_updated_at'
  resources :messages, only:[:create]
  resources :rooms, only:[:create, :show, :index]
  resources :groups do
    resource :group_users, only:[:create, :destroy]
    resources :send_mails, only:[:show, :new, :create]
  end
end
