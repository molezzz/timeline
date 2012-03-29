class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id,:default => 0
      t.string :name,:null => false
      t.string :remark

      t.timestamps
    end
    add_index :categories, :parent_id
    add_index :categories, :name
  end
end
