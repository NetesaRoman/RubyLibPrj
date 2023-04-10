class BibliotekasController < ApplicationController
  def index
    @bibliotekas = Biblioteka.all
  end

  def show
    @biblioteka = Biblioteka.find(params[:id])
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
