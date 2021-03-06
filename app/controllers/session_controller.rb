class SessionController < ApplicationController

    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token

    def new
    # This is the action for user login. The view will have the login form template.
    end

    def create
        # This is the action to which the login form post request is posted. It will add the 
        #user's id to the session hash, which will be used for authentication and 
        #authorization throughout the session.
        user = User.find_by :username => params[:username]
        if user.present? && user.authenticate(params[:password])
            # If a user record with the entered in the form is present AND the user is 
            #authenticated (using bcrypt's authenticate method and the password entered in 
            #the form), store their id in the session hash and redirect them to the root 
            #path.
            session[:user_id] = user.id
            flash[:notice] = 'User created!'
            redirect_to "/msgr/splash"
        else
            # If the user cannot be authenticated, redirect them to the login_path.
            flash[:error] = 'Invalid credentials'
            redirect_to root_path
        end
    end

    def createuser
        salt = BCrypt::Engine.generate_salt
        new_user = User.new
        new_user.username = params[:signup_username]
        new_user.password_digest = BCrypt::Engine.hash_secret(params[:signup_password], salt)
        new_user.age = 18
        new_user.sex = "f"
        new_user.location = "Cali"
        new_user.display_pic = "https://www.placecage.com/300/200"
        new_user.save
        redirect_to root_path
    end

    # This is the action to which the user sign-out delete request is posted.
    def destroy
        session[:user_id] = nil
        redirect_to root_path
    end

end