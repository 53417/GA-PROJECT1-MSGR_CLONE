class MsgrController < ApplicationController
    def login
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    # need to define user login in every single page
    def splash
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    def profile
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    def friends_list
        @logged_in_user = User.find_by :id => session[:user_id]
        @friends = ActiveRecord::Base.connection.exec_query("SELECT * FROM user_friends LEFT JOIN users ON users.id = user_friends.friend_id WHERE user_id = #{@logged_in_user["id"]}")
        # FAILED TRASH
        # @friends = UserFriend.where(user_id: @logged_in_user)
        # @friends2 = UserFriend.joins("LEFT JOIN users ON users.id = 1 AND users.id = user_friends.friend_id")
        # @friends3 = UserFriend.where(user_id: @logged_in_user).joins("LEFT JOIN users ON users.id = user_friends.friend_id") #broken
    end

    def chatrooms_list
        @logged_in_user = User.find_by :id => session[:user_id]
        @chatrooms = ChatroomUser.where(user_id: @logged_in_user)
    end

    def chatroom
        @roomid = params[:id]
        @messages = ChatroomMessage.where(chatroom_id: @roomid)
        @chatroom_users = ChatroomUser.where(chatroom_id: @roomid)
        @chatroom = Chatroom.find_by :id => @roomid
    end

end