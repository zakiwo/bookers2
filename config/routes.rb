Rails.application.routes.draw do
  devise_for :users
  root to:'homes#top'
  get 'home/about' => 'homes#about'
  resources :books do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'search' => 'search#search', as: 'search'
  get 'sort_by_evaluation' => 'sortings#sort_by_evaluation', as: 'sort_by_evaluation'
  get 'sort_by_updated_at' => 'sortings#sort_by_updated_at', as: 'sort_by_updated_at'
end
