
class AdminController < ApplicationController

  include AccessValidator


  def login
    user = User.find_by(email:session_params[:email])
    if user && user.authenticate(session_params[:password])
      token = create_admin_token(user.id)
      set_cookie(token)
      return render json: { message: "Login bem-sucedido", user: user.as_json(except: :password_digest) }, status: :ok
    end

    render json: { error: "Credenciais inválidas" }, status: :unauthorized
  end

  def logout
    cookies.delete(:auth_token)
    render json: { message: "Logout bem-sucedido" }, status: :ok
  end

  def user_info
    is_user_athenticated = validate_admin(cookies)
    if is_user_athenticated
      user = User.find(is_user_athenticated["user_id"])
      permissions = Permission::PERMISSION[user.role.to_sym]
      user_with_permissions = {id:user.id, name: user.name, permissions: permissions}
      render json: user_with_permissions , status: :ok
      end
  end

  private
  def session_params
    params.require(:admin).permit(:email, :password)
  end


end
