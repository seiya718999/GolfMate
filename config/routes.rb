Rails.application.routes.draw do

  namespace :public do
    get 'groups/new'
    get 'groups/index'
    get 'groups/show'
    get 'groups/edit'
  end
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    get 'customers/search' => 'search#customers_search'
    get 'posts/search' => 'search#posts_search'
    get 'posts/favorites', to: 'favorites#index'
    resources :golf_courses, only: [:index, :show]
    resources :posts do
      resources :comments, except: [:show, :index]
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get 'confirm'
        patch 'withdrawal'
      end
      resources :events, except: [:new]
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    root to: 'homes#top'
    get 'customers/search' => 'search#customers_search'
    get 'posts/search' => 'search#posts_search'
    resources :posts, only: [:show, :edit, :update, :destroy] do
      resources :comments, only: [:edit, :update, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
