class Trade < ActiveRecord::Base
    acts_as_taggable
    has_attached_file :screenshot, :styles => { :large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
