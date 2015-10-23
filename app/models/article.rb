class Article < ActiveRecord::Base
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
    
    def tag_list
        self.tags.map { |tag| tag.name }.join(', ')
    end 
    
    def tag_list= (tag_string)
        tag_names = tag_string.split(', ').map { |el| el.strip.downcase }.uniq
        new_or_found_tags = tag_names.map{ |tag| Tag.find_or_create_by(name: tag)}
        self.tags = new_or_found_tags
    end 
end
