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

  # 管理者
  namespace :admin do
    get '/post_comments/:id' => 'post_comments#index',as: 'post_comments'
    get '/posts/:id' => 'posts#index',as: 'posts'
    resources :posts,except: [:edit] do
      resources :post_comments,only: [:destroy]
    end
    resources :users,except: [:destroy]
    root :to => 'users#index'
  end

# 会員
  namespace :public do
    get '/about' => 'homes#about',as: 'about'

    get '/post/:id/index' => 'posts#user_index',as: 'user_posts'
    patch 'post/:id/inex' => 'posts#update',as: 'edit_post'
    resources :posts,except: [:edit] do
      # post '/post/:id/favorite' => 'favorites#create',as: 'favorite'
      # delete '/post/:id/favorite' => 'favorites#delete'
      resource :favorites,only: [:create, :destroy]
      resources :post_comments,only: [:create, :destroy]
    end

    resources :users,except: [:new, :create, :destroy] do
    # 論理削除
    get '/users/withdrawal' => 'users#withdrawal',as: 'withdrawal' #退会確認画面
    patch '/users/breakaway' => 'users#breakaway',as: 'breakaway'
    # id付きで取得
      member do
        get :favorites
      end
    end

    resources :inquiries,only: [:new, :create]
    post '/inquiries/confirm' => 'inquiries#confirm',as: 'mail_confirm'
    post '/inquiries/back' => 'inquiries#back',as: 'mail_back'
    get '/inquiries/mail_done' => 'inquiries#mail_done',as: 'mail_done'

    resources :goals,except: [:destroy, :show]
    get '/goals/induction' => 'goals#induction',as: 'induction'

    resources :objectives,except: [:destroy]

    resources :topics,except: [:edit] do
      resources :topic_comments,only: [:create, :destroy]
    end


    root :to => 'homes#top'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
