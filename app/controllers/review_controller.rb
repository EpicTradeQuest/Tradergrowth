class ReviewController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:query] == ''
            @sum = 0
            @alltrades = current_user.trades
            @trades = Kaminari.paginate_array(current_user.trades.order("created_at desc")).page(params[:page]).per(9)
            # @daterange = @trades.created_between(:startdate, :enddate)
            @tags = 'ALL'
            @tradenumber = @alltrades.count
            @pipresult = @alltrades.sum(:result).round(2)
            @average = @alltrades.average(:result).round(1)
            @winrate = ((@alltrades.where('result > 0').count.to_f / @alltrades.count.to_f) * 100).round(1)
            @largestwin = @alltrades.maximum(:result).round(2)
            @largestloss = @alltrades.minimum(:result).round(2)

        elsif params[:query].present?
                unless current_user.trades.tagged_with(params[:query]).exists?
                    flash.now[:error] = "Hmmm, those tags don't seem to exist!  Try again?"
                    render 'index'
                else
                    @sum = 0
                    @alltrades = current_user.trades.tagged_with(params[:query])
                    @trades = Kaminari.paginate_array(current_user.trades.tagged_with(params[:query]).order("created_at desc")).page(params[:page]).per(9)
                    # @daterange = @trades.created_between(:startdate, :enddate)
                    @tags = params[:query]
                    @tradenumber = @alltrades.count
                    @pipresult = @alltrades.sum(:result).round(2)
                    @average = @alltrades.average(:result).round(1)
                    @winrate = ((@alltrades.where('result > 0').count.to_f / @alltrades.count.to_f) * 100).round(1)
                    @largestwin = @alltrades.maximum(:result).round(2)
                    @largestloss = @alltrades.minimum(:result).round(2)
                end
        else
            @trades = current_user.trades.all
        end
    end
end

