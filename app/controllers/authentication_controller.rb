class AuthenticationController < ApplicationController
    include JsonWebToken
    before_action :authorize_request, except: :login
    # POST /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            # Generate separate access and refresh tokens
            exp = 24.hours.from_now
            exp_reresh = 7.days.from_now
            access_token = JsonWebToken.encode(user_id: @user.id, exp: exp)
            refresh_token = JsonWebToken.encode(user_id: @user.id, exp: exp_reresh, refresh: true)

            # Render response with separate tokens and expiration times
            render json: {
            access_token: access_token,
            access_exp: exp.strftime("%m-%d-%Y %H:%M"),
            refresh_token: refresh_token,
            refresh_exp: exp_reresh.strftime("%m-%d-%Y %H:%M")
            }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    private

    def login_params
        params.permit(:email, :password)
    end
end
