class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :set_var

  def index
    @trade = current_user.trades.build
    @trades = Kaminari.paginate_array(current_user.trades.order("created_at desc")).page(params[:page]).per(9)
    @subscribed = current_user.subscribed
    # @paginatable_array = Kaminari.paginate_array(my_array_object).page(params[:page]).per(10)
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
