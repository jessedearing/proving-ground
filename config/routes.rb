require "#{File.dirname(__FILE__)}/../app/resume/resumeapi"
Jessedearing::Application.routes.draw do
  get '/nodes/:id/comments' => 'nodes#comments'
  get '/page/:page' => 'nodes#index', :as => :node_page
  resources :nodes do
    resources :comments
  end

  get 'blog' => 'nodes#index'
  get 'blog/node/:id' => 'nodes#old_show'

  # RSS feeds
  get 'rss.xml' => 'nodes#rss', :format => :xml
  # This route is to not break old links to my RSS feed
  get 'blog/rss.xml' => 'nodes#rss'

  get 'jd/a/login' => 'admin#login'
  post 'jd/a/login' => 'admin#authenticate'
  get 'jd/a/logout' => 'admin#logout'

  match 'resume' => ResumeApi


  root :to => "nodes#index"

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
  # root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
