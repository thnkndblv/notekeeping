class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: email.downcase)

    if user && user.authenticate(password)
      log_in(user)
      redirect_to(root_path)
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to(root_url)
  end

  private

  def email
    params[:session].fetch(:email)
  end

  def password
    params[:session].fetch(:password)
  end
end
