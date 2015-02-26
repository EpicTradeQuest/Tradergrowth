class ReviewController < ApplicationController
    def index
        if params[:query].present?
            @trades = Trade.tagged_with(params[:query])
        else
            @trades = Trade.all
        end
    end

    def show
        @trades = Trade.tagged_with(params[:query])
        @tags = params[:query]
        @pipresult = @trades.sum :result
    end
end
