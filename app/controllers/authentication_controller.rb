class AuthenticationController < ApplicationController
    # include JsonWebToken
    before_action :authorize_request, except: [:login, :refresh]
    before_action :authorize_refresh_request , only: :refresh

    # POST /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            # Generate separate access and refresh tokens
            exp = 24.hours.from_now
            exp_reresh = 7.days.from_now
            access_token = JsonWebToken.encode(user_id: @user.id, exp: exp)
            refresh_token = JsonWebToken.encode(user_id: @user.id, exp: exp_reresh, refresh: true)
            # Generate Session
            user_agent = request.headers['user-agent']
            # user_agent = "unknown" if user_agent.nil?
            UserSession.create(
                user_id: @user.id, 
                token_digest: Digest::SHA256.hexdigest(access_token),
                token_expiration: exp,
                refresh_token_digest: Digest::SHA256.hexdigest(refresh_token),
                refresh_token_expiration: exp_reresh,
                device: user_agent
            )
            # Render response with separate tokens and expiration times
            render json: {
            access_token: access_token,
            exp: exp.to_i,
            refresh_token: refresh_token,
            exp_reresh: exp_reresh.to_i,
            }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def logout
        @session.destroy
        render json: { result: 'OK' }, status: :ok
    end

    def refresh
        exp = 24.hours.from_now
        access_token = JsonWebToken.encode(user_id: @decoded[:user_id], exp: exp)
        @session.update(
            token_digest: Digest::SHA256.hexdigest(access_token),
            token_expiration: exp,
        )
        render json: { 
            access_token:  access_token,
            exp: exp
        }, status: :ok
    end

    private

    def login_params
        params.permit(:email, :password)
    end
end
