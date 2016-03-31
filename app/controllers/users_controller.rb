class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


    def new
      @user = User.new
    end

    def show
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile Updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

    def index
      @users = User.paginate(page: params[:page])
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "Your profile was deleted"
      redirect_to users_url
    end


  private

  def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation, :user_about_me,
                                  :birthday, :avatar, :gender)

  end

  ##Before filters method
  # Confirms that a given user is logged in. Only when these conditions are met the user will
  # be able to update or edit their page
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger]= "Please Log In"
      redirect_to login_url
    end
  end

# Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

#Confirms an admin user
  def admin_user
    redirect_to(login_url) unless current_user.admin?
  end

end
## You made a mistake here with the end above. You closed the class too early
##which ended up cause a problem for the database to accept the attributes located
## under the private method which means that the database never accepted the user
##input
