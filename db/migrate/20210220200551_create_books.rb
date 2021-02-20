class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :advance
      t.string :year_published
      t.integer :author_id
      t.timestamps
    end
  end
end
