class TagsController < ApplicationController
    def index
        @tags = ActsAsTaggableOn::Tag.all
    end

    def show
        @tag = ActsAsTaggableOn::Tag.find(params[:id])
        @trades = Trade.tagged_with(@tag.name)
        @pipresult = @trades.sum :result
    end

end
