Helloworld::Application.routes.draw do |map|
  match 'profiles/:id(.:format)' => 'profiles#show'
end
