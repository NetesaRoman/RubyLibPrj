class ReaderCardsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @reader_cards = ReaderCard.all
  end

  def show
    @reader_card = ReaderCard.find(params[:id])
  end

  def edit
    @reader_card = ReaderCard.find(params[:id])
  end

  def update
    @reader_card = ReaderCard.find(params[:id])

    @reader_card.update(reader_card_params)

    redirect_to reader_card_path(@reader_card)
  end

  def new
    @reader_card = ReaderCard.new
  end

  def create
    @reader_card = ReaderCard.create(reader_card_params)

    redirect_to root_path
  end

  def destroy
    @reader_card = ReaderCard.find(params[:id])
    @reader_card.destroy

    redirect_to root_path
  end

  private
  def reader_card_params
    params.require(:reader_card).permit(:id)
  end
end
