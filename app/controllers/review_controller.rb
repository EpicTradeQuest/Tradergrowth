class ReviewController < ApplicationController
  before_action :authenticate_user!, :tags_exist?

  def index
    if params[:query] == ''
      @alltrades = current_user.trades
      @trades = Kaminari.paginate_array(current_user.trades.order("created_at desc")).page(params[:page]).per(9)
    else
      @alltrades = current_user.trades.tagged_with(params[:query])
      @trades = Kaminari.paginate_array(current_user.trades.tagged_with(params[:query]).order("created_at desc")).page(params[:page]).per(9)
    end
  end

  private

  def tags_exist?
    if params[:query].blank?
    elsif not current_user.trades.tagged_with(params[:query]).exists?
      flash.now[:error] = "Hmmm, those tags don't seem to exist!  Try again?"
      render :index
    end
  end

end
