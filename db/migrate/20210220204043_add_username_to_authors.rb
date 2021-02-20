class AddUsernameToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :username, :string
  end
end
