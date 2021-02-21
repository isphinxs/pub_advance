class Book < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :author 
    # validates_associated :author # called upon save; default error message "is invalid" 

    def slug
        slug = self.name.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        title_to_search = slug.gsub("-", " ")
        self.find_by(name: title_to_search)
    end
end