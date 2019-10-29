class MsgrController < ApplicationController
    
    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token
    
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

    def profile_update
        profile = User.find_by :id => session[:user_id]
        profile.username = params[:edit_username]
        profile.displayname = params[:edit_displayname]
        profile.age = params[:edit_age]
        profile.save
        redirect_to :controller => 'msgr', :action => 'profile'
    end

    def profile_edit
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

    def chatroom_newmessage
        @logged_in_user = User.find_by :id => session[:user_id]
        message = ChatroomMessage.new
        message.user_id = @logged_in_user.id
        message.chatroom_id = params[:id]
        message.message = params[:message]
        message.save
        redirect_to :controller => 'msgr', :action => 'chatroom'
    end

end