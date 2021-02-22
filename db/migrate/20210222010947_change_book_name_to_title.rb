class ChangeBookNameToTitle < ActiveRecord::Migration[6.1]
  def change
    change_table :books do |t|
      t.rename :name, :title
    end
  end
end
