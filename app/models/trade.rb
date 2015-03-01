class Trade < ActiveRecord::Base
    belongs_to :user
    searchkick
    acts_as_taggable
    has_attached_file :screenshot, :styles => { :large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
    validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
    validates :result, presence: true, length: { maximum: 8 }
    scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end
