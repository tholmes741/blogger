class Article < ActiveRecord::Base
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings
    
    def tag_list
        self.tags.map { |tag| tag.name }.join(', ')
    end 
    
    def tag_list= (tag_string)
        tag_names = tag_string.split(', ').map { |el| el.strip.downcase }.uniq
        new_or_found_tags = tag_names.map{ |tag| Tag.find_or_create_by(name: tag)}
        self.tags = new_or_found_tags
    end 
end
