class UsersController < ApplicationController
  before_action :check, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
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
      # 更新に成功したときの処理
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :region, :email, :password,
                                 :password_confirmation)
  end
  
  def check
    @user = User.find(params[:id])
    redirect_to root_path if current_user != @user
  end
end