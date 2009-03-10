ActionController::Routing::Routes.draw do |map|
 # map.connect '/spaces/userstyle', :controller => 'spaces', :action => 'userstyle'
  map.connect '/spaces/:action', :controller => 'spaces'
  map.resources :spaces, :member => {:set_style => :put, :set_model => :put}, :collection => { :userstyle => :get, :usermodel => :get }
  map.resources :account
  map.resources :messages, :collection => { :message_to => :get, :trashbox => :put },
    :member => { :renew => :put, :reply => :get, :message_delete => :delete }
  map.resources :galleries do |gallery|
    gallery.resources :photos, :member => { :set_primary => :put, :set_avatar => :put } do |photo|
      photo.resources :comments
    end
  end
  map.resources :events
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end

  map.home '', :controller => 'home', :action => 'index'
  map.userhome '/home', :controller => 'users', :action => 'home'
  map.resources :users, :member => { :type_show => :put } do |user|
    user.resources :comments, :member => { :delete_board => :delete }
    user.resources :entries, :member => { :display => :put, :add_tag => :put, :remove_tag => :delete } do |entry|
      entry.resources :comments
    end
    user.resources :shops do |shop|
      shop.resources :products, :member => {:more_photo => :put}
    end
    user.resources :galleries
    user.resources :informations
    user.resources :friends
    user.resources :messages
    user.resources :tags
  end

  map.resources :doc, :collection => {:listpage => :get}
  map.namespace :admin do |admin|
    admin.resources :categories do |category|
      category.resources :products
    end
    admin.resources :shops, :member => { :set_status => :put, :set_recomend => :put}
    admin.resources :home, :collection => {:all_products => :get}
  end
  
  map.doc '/doc', :controller => 'doc'
  map.admin '/admin', :controller => 'admin/home'
  map.userhome '/home', :controller => 'users', :action => 'home'
  map.control '/control', :controller => 'account', :action => 'index'
  map.login '/login', :controller => 'account', :action => 'login'
  map.logout '/logout', :controller => 'account', :action => 'logout'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
