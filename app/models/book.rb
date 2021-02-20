class Book < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :author 
    # validates_associated :author # called upon save; default error message "is invalid" 
end