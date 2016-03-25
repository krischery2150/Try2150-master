class UsersController < ApplicationController
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



  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                  :password_confirmation, :user_about_me,
                                  :birthday, :avatar)

  end

end
## You made a mistake here with the end above. You closed the class too early
##which ended up cause a problem for the database to accept the attributes located
## under the private method which means that the database never accepted the user
##input
