Rails.application.routes.draw do
  root to: 'msgr#login'
  get '/msgr/splash' => 'msgr#splash'
  get '/msgr/friends_list' => 'msgr#friends_list'
  get '/msgr/chatrooms_list' => 'msgr#chatrooms_list'
  get '/msgr/chatroomid' => 'msgr#chatroom'
  get '/msgr/profile' => 'msgr#profile'
end

# get '/planets' => 'planets#index'
# get '/planets/new' => 'planets#new'
# post '/planets' => 'planets#create'
# get '/planets/:id' => 'planets#show', :as => 'planet'
# get '/planets/:id/edit' => 'planets#edit', :as => 'planet_edit'
# post '/planets/:id' => 'planets#update'
# delete '/planets/:id' => 'planets#destroy'