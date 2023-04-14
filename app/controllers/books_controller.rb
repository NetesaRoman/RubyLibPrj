class BooksController < ApplicationController
  before_action :authenticate_admin!
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    @book.update(book_params)

    redirect_to book_path(@book)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)

    redirect_to root_path
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to root_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :biblioteka_id)
  end

end
