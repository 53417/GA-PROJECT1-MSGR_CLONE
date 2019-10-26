class Chatroom < ApplicationRecord
    belongs_to :user
    has_many :chatroom_users
end
