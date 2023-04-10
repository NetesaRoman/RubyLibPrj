class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])

    @author.update(author_params)

    redirect_to author_path(@author)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.create(author_params)

    redirect_to "authors#index", allow_other_host: true
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    redirect_to "authors#index", allow_other_host: true
  end

  private
  def author_params
    params.require(:author).permit(:name)
  end
end
