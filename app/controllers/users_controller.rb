class UsersController < ApplicationController
    before_action :authorize_request
    # GET /users
    # def index
    #     @users = User.all
    #     render json: @users, status: :ok
    # end

    def me
        render json: {current_user: @current_user, decoded: @decoded}, status: :ok
    end
end
