Rails.application.routes.draw do

  # 管理者用　URL/admin/sign_in...
  devise_for :admin, skip:[:registrations, :passwords],controllers:{
    sessions:"admin/sessions"
  }
  # 会員用　URL/users/sign_in...
  devise_for :users, skip:[:passwords],controllers:{
    registrations:"public/registrations",
    sessions:'public/sessions'
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  namespace :admin do
  end

  namespace :public do
    get '/about' => 'homes#about',as: 'about'
    get '/post/:id/index' => 'posts#user_index',as: 'user_posts'
    post '/post/:id/favorite' => 'favorites#create',as: 'favorite'
    delete '/post/:id/favorite' => 'favorites#delete'
    resources :posts,except: [:update, :edit]
    resources :users,except: [:new, :create]
    root :to => 'homes#top'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
