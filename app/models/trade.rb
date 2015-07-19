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



end
