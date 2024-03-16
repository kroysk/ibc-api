class UsersController < ApplicationController
    before_action :authorize_request
    # GET /users
    # def index
    #     @users = User.all
    #     render json: @users, status: :ok
    # end

    def me
        current_user = @current_user.as_json(except: [:password_digest])
        current_user[:roles] = @current_user.roles.pluck(:code)
        render_success current_user
    end
end
