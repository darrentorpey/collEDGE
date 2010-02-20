ActionController::Routing::Routes.draw do |map|
  map.resources :events

  map.resources :users

  map.resources :people

  map.namespace(:backend) do |backend|
    backend.resources :events
    backend.resources :people
    backend.resources :accounts
    backend.resources :sessions
  end

  map.backend                 '/backend',              :controller => 'backend/base', :action => 'index'
  map.connect                 '/javascripts/:action.:format', :controller => 'javascripts'

  map.admin_events 'admin/events', :controller => 'admin/events'
  map.admin_events 'admin/testing', :controller => 'admin/testing'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # map.home '', :controller => 'home', :action => 'dashboard'
  # map.with_options :controller => 'sessions'  do |m|
  #   m.login  '/login',  :action => 'new'
  #   m.logout '/logout', :action => 'destroy'
  # end

  map.root :controller => 'launch_pad'

  ###################################################################
  # Install the default routes
  ###################################################################
  
  map.connect ':controller', :action => 'index'
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
end
