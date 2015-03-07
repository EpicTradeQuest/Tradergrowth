class ReviewController < ApplicationController
    before_action :authenticate_user!

    def index
        unless params[:query].present?
            @trades = current_user.trades.all
            @tags = "All trades"
            @pipresult = @trades.sum :result
            @average = @trades.average(:result).round(1)
            @winrate = ((@trades.where('result > 0').count.to_f / @trades.count.to_f) * 100).round(1)
            @largestwin = @trades.maximum :result
            @largestloss = @trades.minimum :result
        elsif params[:query].present?
                unless current_user.trades.tagged_with(params[:query]).exists?
                    flash.now[:error] = "Hmmm, those tags don't seem to exist!  Try again?"
                    render 'index'
                else
                    @sum = 0
                    @trades = current_user.trades.tagged_with(params[:query])
                    # @daterange = @trades.created_between(:startdate, :enddate)
                    @tags = params[:query]
                    @pipresult = @trades.sum :result
                    @average = @trades.average(:result).round(1)
                    @winrate = ((@trades.where('result > 0').count.to_f / @trades.count.to_f) * 100).round(1)
                    @largestwin = @trades.maximum :result
                    @largestloss = @trades.minimum :result
                end
        end
    end
end

