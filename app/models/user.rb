class User < ApplicationRecord
    has_secure_password
    has_many :chatrooms
    has_many :chatroom_messages
    has_many :chatroom_users
    has_many :user_friends
end
