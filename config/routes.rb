Helloworld::Application.routes.draw do |map|
  map.resources :profiles
  match 'public/:id(.:format)' => 'profile#show_public'
end
