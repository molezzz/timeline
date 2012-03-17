class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.integer :timeline_id
      t.string :name
      t.string :icode
      t.string :status
      t.text :description
      t.string :logo

      t.timestamps
    end
    add_index :merchants, :timeline_id
    add_index :merchants, :icode
    add_index :merchants, :status
  end
end
