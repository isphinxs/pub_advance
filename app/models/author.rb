class Author < ActiveRecord::Base
    validates :name, :password, :username, presence: true
    validates :username, uniqueness: { message: "This username is taken. Select another username."}

    has_secure_password
    has_many :books
end