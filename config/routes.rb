DashboardMy::Application.routes.draw do


  domain ':city_id.*locale_domain', :locale_domain => Regexp.new(LOCALE_DOMAINS.values.join('|')) do
    root :to => "cities#show"
    match '*caturlpath' => 'categories#show', :as => :city_category,
          :format => false, :constraints => {:caturlpath => /[a-z0-9\-\/]+/}
  end

  domain '*locale_domain', :locale_domain => Regexp.new(LOCALE_DOMAINS.values.join('|')) do
    root :to => 'cities#index'
    match '*caturlpath' => 'categories#show', :as => :category,
          :format => false, :constraints => {:caturlpath => /[a-z0-9\-\/]+/}
  end
  #match 'gondon/:id/:test' => "cities#test"


=begin
  scope "(:locale)", :locale => Regexp.new(I18n.available_locales.join('|')) do
    root :to => 'cities#index'
    #devise_for :users, :sign_out_via => [ :get ], :controllers => { :omniauth_callbacks => "users/omniauth", :registrations => "users/registrations" }
    #resources :users, :only => [:index, :show]

    #:constraints=>lambda{|req| !req.path.match(/\.(png|jpg|css|js)$/)

    #resources :cities, :only => [:show] do
    #  match '*caturlpath' => 'categories#show', :as => :category, :format => false, :constraints => {:caturlpath => /[a-z0-9\-\/]+/}
    #end

    match '*caturlpath' => 'categories#show', :as => :category, :format => false, :constraints => {:caturlpath => /[a-z0-9\-\/]+/}
  end
=end



  # http://guides.rubyonrails.org/routing.html
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
  # root :to => 'offers#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
