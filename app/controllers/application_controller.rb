class ApplicationController < ActionController::API
    
    def render_error(data, status = :bad_request)
        render json: { error: true, result: data }, status: status
    end

    def render_success(data, status = :ok)
        render json: { error: false, reuslt: data }, status: status
    end

    def render_not_found
        render_error "No se encontró la ruta", :not_found
    end

    def not_permission
        render_error "No Autorizado", :unauthorized
    end
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            token_digest = Digest::SHA256.hexdigest(header)
            @session = UserSession.find_by(user_id: @decoded[:user_id], token_digest: token_digest)
            if @session.nil?
                raise ActiveRecord::RecordNotFound, "Token Invalido"
            end
            # @current_user = User.includes(:roles).find(@decoded[:user_id]).as_json(except: [:password_digest], include: {})
            @current_user = User.find(@decoded[:user_id])
          
        rescue ActiveRecord::RecordNotFound => e
            render_error e.message, :unauthorized
        rescue JWT::DecodeError => e
            render_error e.message, :unauthorized
        end
    end

    def authorize_refresh_request
        header = request.headers['x-refresh-token']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            token_digest = Digest::SHA256.hexdigest(header)
            @session = UserSession.find_by(user_id: @decoded[:user_id], refresh_token_digest: token_digest)
            if @session.nil?
                raise ActiveRecord::RecordNotFound, "Token Invalido"
            end
            @current_user = User.find(@decoded[:user_id]).as_json(except: [:password_digest])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    def has_permissions?(permission)
        return true if @current_user.roles.pluck(:code).include?('superadmin')
        return true if permission != 'superadmin' && @current_user.roles.pluck(:code).include?('admin')
        if @current_user.roles.flat_map(&:permissions).pluck(:resource).include?(permission)
            return true
        else
            return false
        end
    end
end
