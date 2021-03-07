class Author < ActiveRecord::Base
    validates :name, :password, :username, presence: true, :on => :create
    validates :username, uniqueness: { message: "This username is taken. Select another username."}, :on => :create

    has_secure_password
    has_many :books

    def slug
        slug = self.name.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.detect do |author|
            author.slug == slug
        end
    end
end