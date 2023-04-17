require 'kaminari'

class BibliotekasController < ApplicationController


  before_action :authenticate_admin!

  def index


    @q = Biblioteka.ransack(params[:q])
    @bibliotekas = @q.result(distinct: true).includes(:books)


    @bibliotekas = @bibliotekas.order(:name) if params[:sort] == "name"
    @bibliotekas = @bibliotekas.sort_by { |biblioteka| biblioteka.books.count } if params[:sort] == "book_count"
    @bibliotekas = @bibliotekas.sort_by { |biblioteka| biblioteka.books.select(:genre_id).distinct.count } if params[:sort] == "genre_count"
    @bibliotekas = Kaminari.paginate_array(@bibliotekas).page(params[:page]).per(10)
  end



  def show
    @biblioteka = Biblioteka.find(params[:id])
    @users = User.joins(:reader_card).where(reader_cards: {biblioteka_id: @biblioteka.id})
    @users = @users.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(age: params[:age]) if params[:age].present?

    @users = @users.order(:name) if params[:sort] == "name"
    @users = @users.sort_by { |user| user.age } if params[:sort] == "age"
    @users = @users.sort_by { |user| user.reader_card.id} if params[:sort] == "card"


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

    redirect_to root_path
  end

  def destroy
    @biblioteka = Biblioteka.find(params[:id])
    @biblioteka.destroy

    redirect_to root_path
  end

  private
  def biblioteka_params
    params.require(:biblioteka).permit(:name)
  end
end
