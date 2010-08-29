Helloworld::Application.routes.draw do |map|
  get "home/dashboard"

  get "auth/login"
  get "auth/logout"
  get "auth/register"
  map.register_user 'auth/register_user', :controller => 'auth', :action => 'register_user'
  map.authenticate "auth/authenticate", :controller => 'auth', :action => 'authenticate'

  match 'home' => 'home#dashboard', :as => :dashboard
  match 'messages' => 'home#messages', :as => :messages
  match 'contacts' => 'home#contacts', :as => :contacts
  match 'profile' => 'home#profile', :as => :profile
  match 'about' => 'home#about', :as => :about

  map.resources :profiles

  match 'public/:id(.:format)' => 'profiles#show_public'

end
