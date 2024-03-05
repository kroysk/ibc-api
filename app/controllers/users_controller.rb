class UsersController < ApplicationController
    before_action :authorize_request
    # GET /users
    # def index
    #     @users = User.all
    #     render json: @users, status: :ok
    # end

    def me
        render json:  @current_user, status: :ok
    end
end
