class ReviewController < ApplicationController
    def index
        if params[:query].present?
            @trades = Trade.tagged_with.search(params[:query])
        else
            @trades = Trade.all
        end
    end

    def show
        @trades = Trade.tagged_with(params[:query])
        @tags = params[:query]
        @pipresult = @trades.sum :result
        @average = @trades.average(:result).round(1)
        @winrate = ((@trades.where('result > 0').count.to_f / @trades.count.to_f) * 100).round(1)
    end

    def autocomplete
        render json: Trade.search(params[:query], autocomplete: true)
    end

end
