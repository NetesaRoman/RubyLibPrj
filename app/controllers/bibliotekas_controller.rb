require 'kaminari'

class BibliotekasController < ApplicationController

  before_action :authenticate_admin!

  def index

    @up = false
    @up_genre = false
    @q = Biblioteka.ransack(params[:q])
    @bibliotekas = @q.result(distinct: true).includes(:books)

    @bibliotekas = @bibliotekas.order(:name) if params[:sort] == "name"
    if params[:sort] == "book_count"
      @bibliotekas = @bibliotekas.sort_by { |biblioteka| biblioteka.books.count }
      @up = false
    end

    if params[:sort] == "book_count_desc"
      @bibliotekas = @bibliotekas.sort_by{ |biblioteka| biblioteka.books.count}.reverse
      @up = true
    end

    if params[:sort] == "genre_count"
      @bibliotekas = @bibliotekas.sort_by { |biblioteka| biblioteka.books.select(:genre_id).distinct.count }
      @up_genre = false
    end
    if params[:sort] == "genre_count_desc"
      @bibliotekas = @bibliotekas.sort_by { |biblioteka| biblioteka.books.select(:genre_id).distinct.count }.reverse
      @up_genre = true
    end

    @bibliotekas = Kaminari.paginate_array(@bibliotekas).page(params[:page]).per(10)
  end

  def show
    @up_age = false
    @up_card = false
    @biblioteka = Biblioteka.find(params[:id])
    @users = User.joins(:reader_card).where(reader_cards: { biblioteka_id: @biblioteka.id })
    @users = @users.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(age: params[:age]) if params[:age].present?

    @users = @users.order(:name) if params[:sort] == "name"
    if params[:sort] == "age"
      @users = @users.sort_by { |user| user.age }
      @up_age = false
    end
    if params[:sort] == "age_desc"
      @users = @users.sort_by { |user| user.age }.reverse
      @up_age = true
    end
    if params[:sort] == "card"
      @users = @users.sort_by { |user| user.reader_card.id }
      @up_card = false
    end
    if params[:sort] == "card_desc"
      @users = @users.sort_by { |user| user.reader_card.id }.reverse
      @up_card = true
    end


    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end

  def edit
    @biblioteka = Biblioteka.find(params[:id])
  end

  def update
    @biblioteka = Biblioteka.find(params[:id])

    @biblioteka.update(biblioteka_params)

    redirect_to biblioteka_path(@biblioteka)
  end

  def new
    @biblioteka = Biblioteka.new
  end

  def create
    @biblioteka = Biblioteka.create(biblioteka_params)

    if @biblioteka.save
      # Загрузка файла на сервер
      uploaded_file = params[:biblioteka][:image]
      file_path = Rails.root.join('public', 'bibliotekas', uploaded_file.original_filename)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end

      # Сохранение пути к файлу в базе данных
      @biblioteka.image = "/bibliotekas/#{uploaded_file.original_filename}"
      @biblioteka.save


      redirect_to bibliotekas_path, allow_other_host: true
    else
      render :new
    end
  end

  def destroy
    @biblioteka = Biblioteka.find(params[:id])
    @biblioteka.destroy

    redirect_to root_path
  end

  private

  def biblioteka_params
    params.require(:biblioteka).permit(:name, :image, :address, :phone)
  end
end
