Rails.application.routes.draw do
  root to: 'msgr#login'

  get '/login' => 'session#new'         # This will be our sign-in page.
  post '/login' => 'session#create'     # This will be the path to which the sign-in form is posted
  delete '/login' => 'session#destroy'  # This will be the path users use to log-out.

  get '/msgr/splash' => 'msgr#splash'
  get '/msgr/friends_list' => 'msgr#friends_list'
  post '/msgr/friends_list/add' => 'msgr#friends_list_add_friend'
  get '/msgr/chatrooms_list' => 'msgr#chatrooms_list'
  get '/msgr/chatroom/:id' => 'msgr#chatroom', :as => 'chatroom'
  post '/msgr/chatroom/:id' => 'msgr#chatroom_newmessage'
  post 'msgr/chatroom/:id/update' => "msgr#chatroom_update"
  post 'msgr/chatroom/:id/add_member' => "msgr#chatroom_add_member"
  post 'msgr/chatroom/:id/leave' => "msgr#chatroom_leave"
  get '/msgr/profile' => 'msgr#profile'
  post '/msgr/profile/edit' => 'msgr#profile_update'
  get '/msgr/profile/edit' => 'msgr#profile_edit'
end

# get '/planets' => 'planets#index'
# get '/planets/new' => 'planets#new'
# post '/planets' => 'planets#create'
# get '/planets/:id' => 'planets#show', :as => 'planet'
# get '/planets/:id/edit' => 'planets#edit', :as => 'planet_edit'
# post '/planets/:id' => 'planets#update'
# delete '/planets/:id' => 'planets#destroy'