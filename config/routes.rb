Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
 }
  root to: "homes#index"
  resources :users, only:[:index, :show, :new, :destroy]

  resources :products, only:[:show, :new, :destroy, :edit, :update] do

      collection do
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
  end

  resources :confirmations, only: :index
  resources :categories, only: :index
  resources :sign_up do
    collection do
      get 'information_first'
      get 'information_second'
      get 'done'
    end
  end

  resources "users",only: :logout, path: '' do
    collection do
      get 'logout'
    end

  end 

  resources :homes do 
    collection do
      get 'category_children' 
      get 'category_grandchildren'
    end
  end

  
  resources :card, only: [:index]
  resources :card, only: [:new, :show,] do
    collection do
      get 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end

  resources :products, shallow: true do
    resources :purchase do
      post :pay, on: :collection
      get :done, on: :collection
    end
end

end
