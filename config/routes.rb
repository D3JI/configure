ActionController::Routing::Routes.draw do |map|
  map.home '', :controller => 'home'
  map.resources :users do |user|
    user.resources :entries, :member => { :display => :put } do |entry|
      entry.resources :comments
    end
  end
  map.login '/login', :controller => 'account', :action => 'login'
  map.logout '/logout', :controller => 'account', :action => 'logout'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
