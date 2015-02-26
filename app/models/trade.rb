class Trade < ActiveRecord::Base
    searchkick autocomplete: ['tagged_with']
    acts_as_taggable
    has_attached_file :screenshot, :styles => { :large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
    validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
