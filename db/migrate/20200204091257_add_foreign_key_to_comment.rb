class AddForeignKeyToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :foreign_key, :true
  end
end
