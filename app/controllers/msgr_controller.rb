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

end