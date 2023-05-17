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

    if @user.save
      # Загрузка файла на сервер
      uploaded_file = params[:user][:image]
      file_path = Rails.root.join('public', 'users', uploaded_file.original_filename)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end

      # Сохранение пути к файлу в базе данных
      @user.image = "/users/#{uploaded_file.original_filename}"
      @user.save


      redirect_to users_path, allow_other_host: true
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :email, :age)
  end
end
