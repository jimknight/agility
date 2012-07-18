Agility::Application.routes.draw do

  resources :comments

  get "timeline" => "news#timeline", :as => "timeline"

  match "projects/:id/user_add/:user_id" => "projects#user_add"
  match "projects/:id/user_search" => "projects#user_search"
  match "/bookmarklet" => "notes#bookmarklet"
  
  # devise_for :users, :controllers => {:registrations => "registrations"},
  #                    :controllers => {:omniauth_callbacks => "omniauth_callbacks"}
  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

  resources :emails do
    resources :emails
    resources :notes
    resources :tasks
  end

  resources :notes do
    resources :notes
  end

  resources :projects do
    resources :emails
    resources :messages
    resources :notes
    resources :tasks
  end
  
  resources :tasks do
    resources :notes
  end

  root :to => "news#timeline"
  match 'tasks/:id/complete' => 'tasks#complete', :as => 'complete_task'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
