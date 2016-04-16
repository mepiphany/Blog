class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email,
                                               :password, :password_confirmation,
                                               :auth_token, :password_reset_token,
                                               :password_reset_sent_at)
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Account has been created!"
    else
      #  binding.pry
      flash[:alert] = "Account wasn't created!"
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email)
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to root_path, notice: "Your Information has been updated!"
    else
      flash[:alert] = "Your Information wasn't updated!"
      render :edit
    end
  end

  def edit_password
    @user = User.find params[:id]
  end

  def update_password
    @user = User.find params[:id]
    user_params = params.require(:user).permit(:current_password, :password, :password_confirmation)
    if @user.authenticate(user_params[:current_password]) && @user.update(user_params)
       redirect_to root_path, notice: "Your password has been updated!"
     else
       flash[:alert] = "Your password is not updated!"
       render :edit_password
     end
  end
end
