class Trade < ActiveRecord::Base
    belongs_to :user
    searchkick
    acts_as_taggable
    has_attached_file :screenshot, :styles => { :large => "800x800>", :medium => "400x400>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
    validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
    validates_with AttachmentSizeValidator, :attributes => :screenshot, :less_than => 2.megabytes

    has_attached_file :screenshot,
    :storage => :fog,
    :fog_credentials => {:provider => "AWS",
                                    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]},
    :fog_directory => 'tradejournal',
    :styles => { :large => "800x800>", :medium => "400x400>", :thumb => "100x100>" },
    :default_url => ":style/missing.png"

    validates :result, presence: true, length: { maximum: 8 }
    scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end
