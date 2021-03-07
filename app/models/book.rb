class Book < ActiveRecord::Base
    validates :title, presence: true
    validates :advance, numericality: true
    belongs_to :author 
    # validates_associated :author # called upon save; default error message "is invalid" 

    def slug
        slug = self.title.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.detect do |book|
            book.slug == slug
        end
    end

    def format_advance
        if self.advance
            digits = self.advance.gsub(/[$,]/, "")
            formatted_advance = digits.rpartition(/.{3}/).reject(&:empty?).join(",")
        end
    end
end