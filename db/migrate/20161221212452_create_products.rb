class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :text
      t.string :product_type
      t.integer :reorder_level
      t.boolean :can_be_sold
      t.boolean :can_be_purchased

      t.timestamps
    end
  end
end
