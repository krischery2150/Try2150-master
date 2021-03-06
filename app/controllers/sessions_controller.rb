class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        ##if this is true the user is logged in and redirectred to the show page
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        remember user
        redirect_to user
    else
    flash.now[:danger]='Invalid email/ password combination'##create an error message
    render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
