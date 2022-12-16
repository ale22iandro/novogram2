Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :comments
    get 'search/index'
    get 'search/favorites'
    devise_for :users
    get 'home/index'
    root to: 'home#index'
    resources :users
    resources :posts

    get 'search' => 'search#index'
    put '/post/:id/like', to: 'posts#like', as: 'like'
    resources :posts do
    # Вложенный ресурс комментов
    # Нам понадобится два экшена: create и destroy
      resources :comments, only: [:create, :destroy]
    end
    put '/user/:id/subscribe', to: 'users#subscribe', as: 'subscribe'
    delete '/user/:id/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
