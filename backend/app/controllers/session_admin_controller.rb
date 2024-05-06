
class SessionAdminController < ApplicationController

  skip_before_action :authenticate_admin, only: [:login]

  def login

     user = User.find_by(email:session_params[:email])

    if user && user.authenticate(session_params[:password])

      create_admin_token(user.id)

      user_info = user_with_permissions(user)

      return render json: { message: "Login bem-sucedido", user:user_info }, status: :ok
    end

    render json: { error: "Credenciais inválidas" }, status: :unauthorized
  end


  def logout
    cookies.delete(:check_token)
    cookies.delete(:auth_token)
    render json: { message: "Logout bem-sucedido" }, status: :ok
  end



  private
  def session_params
    params.require(:session_admin).permit(:email, :password)
  end

  def user_with_permissions(user)
    permissions = Permission::PERMISSION[user.role.to_sym]
    user_with_permissions = {id:user.id, name: user.name, permissions: permissions}
  end

end
