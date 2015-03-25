class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :set_var

  def index
    @trade = current_user.trades.build
    @trades = current_user.trades.all
    @subscribed = current_user.subscribed
  end

  def show
  end

  def edit
  end

  def create
    @trade = current_user.trades.build(trade_params)

    if @trade.save
      flash[:success] = "Trade successfully logged."
      redirect_to action: 'index'
    else
      flash[:alert] = "You can't submit an empty trade!"
      redirect_to action: 'index'
    end
  end

  def update
    if @trade.update(trade_params)
      flash[:success]= 'Trade was successfully updated!'
      redirect_to action: 'index'
    else
      flash[:alert]= 'Update unsuccessful'
      render :edit
    end
  end

  def destroy
    @trade.destroy
      flash[:success]= 'Trade was successfully deleted.'
      redirect_to action: 'index'
  end

  private

    def set_trade
      @trade = Trade.find(params[:id])
    end

    def trade_params
      params.require(:trade).permit(:result, :description, :tag_list, :screenshot, :entry, :stoploss, :targetone, :targettwo, :targetthree)
    end
end
