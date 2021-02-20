class Author < ActiveRecord::Base
    validates :name, :password, :username, presence: true

    has_secure_password
    has_many :books
end