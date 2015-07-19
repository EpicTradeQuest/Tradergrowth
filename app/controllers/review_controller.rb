class ReviewController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].empty?
      @sum = 0
      @alltrades = current_user.trades
      @trades = Kaminari.paginate_array(current_user.trades.order("created_at desc")).page(params[:page]).per(9)
    elsif params[:query].present?
      unless current_user.trades.tagged_with(params[:query]).exists?
        flash.now[:error] = "Hmmm, those tags don't seem to exist!  Try again?"
        render 'index'
      else
        @sum = 0
        @alltrades = current_user.trades.tagged_with(params[:query])
        @trades = Kaminari.paginate_array(current_user.trades.tagged_with(params[:query]).order("created_at desc")).page(params[:page]).per(9)
      end
    else
      @trades = current_user.trades.all
    end
  end
end
