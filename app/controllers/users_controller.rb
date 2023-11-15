class UsersController < ApplicationController
  before_action :already_login?, only: [:new, :create]
  before_action :login?, only: :show
  
  def new
    @user = User.new
  end

  def create
    existing_user = User.find_by_name(params[:user][:name])

    if existing_user
      flash[:notice] = " "
      render :new
    else
      user = User.new(user_params)
    
      if user.save
        session[:user_id] = user.id
        flash[:notice] = "You have successfully logged in."
        redirect_to user_path(user.id)
      else
        render :new
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end