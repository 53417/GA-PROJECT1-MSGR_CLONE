class UsersController < ApplicationController
    before_action :authorise_user, :except => [:index]
end