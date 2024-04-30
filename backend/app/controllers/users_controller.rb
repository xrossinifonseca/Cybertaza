class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
    render json: {users: users_without_password(@users) }
  end

  def current_user_information
    permissions = Permission::PERMISSION[@current_user.role.to_sym]
    user = {id:@current_user.id, name: @current_user.name, permissions: permissions}
    render json: user
  end



  private
    # def set_user
    #   @user = User.find(params[:id])
    # end

    def user_params
      params.require(:user).permit(:name, :email, :password_digest)
    end

    def users_without_password(user)
      user.as_json(except: :password_digest)
   end

end
