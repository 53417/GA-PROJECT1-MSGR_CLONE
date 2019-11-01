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
        profile.display_pic = params[:edit_display_pic]
        profile.age = params[:edit_age]
        profile.sex = params[:edit_sex]
        profile.location = params[:edit_location]
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

    def friends_list_add_friend
        friend = User.find_by :username => params[:add_friend_username]
        new_friend = UserFriend.new
        new_friend.user_id = session[:user_id]
        new_friend.friend_id = friend.id
        new_friend.save
        redirect_to :controller => 'msgr', :action => 'friends_list'
    end

    def friends_list_delete_friend
        @friend = params[:id]
        @user = session[:user_id]
        friends_list = UserFriend.where(user_id: @user, friend_id: @friend)
        friends_list.each{|link| link.destroy}
        redirect_to :controller => 'msgr', :action => 'friends_list'
    end

    def chatrooms_list
        @logged_in_user = User.find_by :id => session[:user_id]
        @chatrooms = ChatroomUser.where(user_id: @logged_in_user)
    end

    def chatrooms_list_join
        @chatroom = Chatroom.where(room_name: params[:room_search])
        @chatroom.each do |room|
            join = ChatroomUser.new
            join.user_id = session[:user_id]
            join.chatroom_id = room.id
            join.is_admin = false
            join.save
        end
        redirect_to :controller => 'msgr', :action => 'chatrooms_list'
    end

    def chatrooms_list_create
        @user = User.where(id: session[:user_id])
        new_room = Chatroom.new
        new_room.user_id = session[:user_id]
        new_room.room_name = 'New chatroom'
        new_room.save
        room_user = ChatroomUser.new
        room_user.user_id = session[:user_id]
        room_user.chatroom_id = new_room.id
        room_user.is_admin = true
        room_user.save
        redirect_to :controller => 'msgr', :action => 'chatrooms_list'
    end

    def chatroom
        @roomid = params[:id]
        @messages = ChatroomMessage.where(chatroom_id: @roomid)
        @chatroom_users = ChatroomUser.where(chatroom_id: @roomid)
        @members_detailed = ActiveRecord::Base.connection.exec_query("SELECT * FROM chatroom_users LEFT JOIN users ON users.id = chatroom_users.user_id WHERE chatroom_id = #{@roomid}")
        @chatroom = Chatroom.find_by :id => @roomid
    end

    def chatroom_update
        chatroom = Chatroom.find_by :id => params[:id]
        chatroom.room_name = params[:update_room_name]
        chatroom.save
        redirect_to :controller => 'msgr', :action => 'chatroom'
    end

    def chatroom_add_member
        chatroom = Chatroom.find_by :id => params[:id]
        member = User.find_by :username => params[:add_member_username]
        new_member = ChatroomUser.new
        new_member.user_id = member.id
        new_member.chatroom_id = params[:id]
        new_member.is_admin = false
        new_member.save
        redirect_to :controller => 'msgr', :action => 'chatroom'
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

    def chatroom_leave
        @chatroom = params[:id]
        chatroom_users = ChatroomUser.where({user_id: session[:user_id], chatroom_id: @chatroom })
        chatroom_users.each{|link| link.destroy}
        redirect_to :controller => 'msgr', :action => 'chatrooms_list'
    end

end

# User.where({ name: "Joe", email: "joe@example.com" })
# SELECT * FROM users WHERE name = 'Joe' AND email = 'joe@example.com'