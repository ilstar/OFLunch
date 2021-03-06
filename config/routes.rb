# -*- encoding : utf-8 -*-
OFLunch::Application.routes.draw do

  resources :stats, only: %w{} do
    collection do
      get :popular_menus
    end
  end

  get "menu_items/index"

  namespace :admin do

    resources :menu_items, only: %w{update}
    resources :vendors, only: %w{index create update destroy} do
      resources :menu_items, only: %w{index create destroy}
    end
    
    resources :balances, only: %w{index}
    resources :balance_logs, :only => %w{create}

    resources :meal_times, except: [:new, :show] do
      member do
        put :lock
        put :unlock
        put :close
      end
    end

  end

  resources :vendors, only: %w{index} do
    resources :menu_items, only: %w{index}
  end

  resources :messages, only: [] do
    member do
      put :redirect
      put :ignore
    end
  end

  resources :bills, only: [:index]

  get "order_items/index"

  resources :order_items, :only => [:index] do
    member do
      put :rating
      put :comment
    end
  end
  get 'order_items/:date' => 'order_items#index', as: 'date_order_items'

  resources :orders, only: %w{index new edit create update destroy}

  devise_for :users

  resource :user, only: [:edit, :update] do
    get 'edit_password'
    put 'update_password'
  end

  resources :sessions, only: [:index] do
    collection do
      put :change
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'orders#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
