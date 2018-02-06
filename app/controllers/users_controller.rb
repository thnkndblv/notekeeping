class UsersController < ApplicationController
  def show
    redirect_to(root_url) unless logged_in?
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to(root_path)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to(signup_path)
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
