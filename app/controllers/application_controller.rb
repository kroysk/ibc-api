class ApplicationController < ActionController::API
    def render_not_found
        render json: { error: "No se encontró la ruta" }, status: :not_found
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id]).as_json(except: [:password_digest])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    # def has_permission?(permission = nil)
    #       # Obtiene los roles del usuario.
    #     # roles = user.roles.pluck(:name)

    #     # # Busca si el usuario tiene un rol con el permiso.
    #     # Role.with_permission(permission_name).pluck(:name).any? do |role_name|
    #     #     roles.include?(role_name)
    # end

    #  end
    # end
end
