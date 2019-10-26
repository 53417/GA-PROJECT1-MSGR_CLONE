class MsgrController < ApplicationController
    def login
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    # need to define user login in every single page
    def splash
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    def chatrooms_list
        @logged_in_user = User.find_by :id => session[:user_id]
        @chatrooms = ChatroomUser.where(user_id: @logged_in_user)
    end

    def profile
        @logged_in_user = User.find_by :id => session[:user_id]
    end

    def friends_list
        @logged_in_user = User.find_by :id => session[:user_id]
        @friends = UserFriend.where(user_id: @logged_in_user)
        # @friends2 = UserFriend.joins("LEFT JOIN users ON users.id = 1 AND users.id = user_friends.friend_id")
        @friends2 = ActiveRecord::Base.connection.execute(sql)
        #sql = "SELECT * FROM user_friends LEFT JOIN users ON users.id = user_friends.friend_id WHERE user_id = 1"
        #UserFriend.where(user_id: @logged_in_user).joins("LEFT JOIN users ON users.id = user_friends.friend_id")
    end

    # User.joins("LEFT JOIN bookmarks ON bookmarks.bookmarkable_type = 'Post' AND bookmarks.user_id = users.id")
    # SELECT "users".* FROM "users" LEFT JOIN bookmarks ON bookmarks.bookmarkable_type = 'Post' AND bookmarks.user_id = users.id

    # SELECT "user_friends".*, "users".* FROM user_friends LEFT JOIN users ON users.id = user_friends.friend_id WHERE user_id = 1;

    # SELECT "user_friends".*, "users".* FROM user_friends LEFT JOIN users ON users.id = user_friends.friend_id WHERE user_id = 1;

    # UserFriend.joins("LEFT JOIN users ON users.id = user_friends.friend_id").where(user_id: @logged_in_user)

    def chatroom
        @chatroom = chatroom.find params[:id]
        @chatroom_users = chatroom_users


    end

end