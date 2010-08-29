Helloworld::Application.routes.draw do |map|
  get "home/dashboard"

  get "auth/login"
  get "auth/logout"
  get "auth/register"
  map.register_user 'auth/register_user', :controller => 'auth', :action => 'register_user'
  map.authenticate "auth/authenticate", :controller => 'auth', :action => 'authenticate'
  map.home "home", :controller => 'home', :action => 'dashboard'

  map.resources :profiles
  match 'public/:id(.:format)' => 'profiles#show_public'

end
