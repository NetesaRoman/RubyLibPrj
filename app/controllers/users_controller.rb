class UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)

    redirect_to user_path(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
