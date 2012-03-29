class AddCategoryIdToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :category_id, :integer
    add_index :merchants, :category_id

  end
end
