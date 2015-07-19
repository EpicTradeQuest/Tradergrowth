class Trade < ActiveRecord::Base
    belongs_to :user
    acts_as_taggable

    # Attributes for paperclip images
    has_attached_file :screenshot,
    :storage => :fog,
    :fog_credentials => {:provider => "AWS",
                                    aws_access_key_id: ENV['aws_access_key_id'],aws_secret_access_key: ENV['aws_secret_access_key'] },
    :fog_directory => 'tradejournal',
    :styles => { :medium => "400x400>" },
    :default_url => ":style/missing.png"

    # Form validations for trade submission form
    validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
    validates_with AttachmentSizeValidator, :attributes => :screenshot, :less_than => 2.megabytes
    validates :result, presence: true, length: { maximum: 8 }
    validates :entry, length: { maximum: 8 }
    validates :stoploss, length: { maximum: 8 }
    validates :targetone, length: { maximum: 8 }
    validates :targettwo, length: { maximum: 8 }
    validates :targetthree, length: { maximum: 8 }




    # if params[:query] == ''
    #     @sum = 0
    #     @alltrades = current_user.trades
    #     @trades = Kaminari.paginate_array(current_user.trades.order("created_at desc")).page(params[:page]).per(9)
    #     # @daterange = @trades.created_between(:startdate, :enddate)
    #     @tags = 'ALL'
    #     @tradenumber = @alltrades.count
    #     @pipresult = @alltrades.sum(:result).round(2)
    #     @average = @alltrades.average(:result).round(1)
    #     @winrate = ((@alltrades.where('result > 0').count.to_f / @alltrades.count.to_f) * 100).round(1)
    #     @largestwin = @alltrades.maximum(:result).round(2)
    #     @largestloss = @alltrades.minimum(:result).round(2)


end
