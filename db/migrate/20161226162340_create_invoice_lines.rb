class CreateInvoiceLines < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_lines do |t|
      t.references :invoice, foreign_key: true
      t.references :product, foreign_key: true
      t.text :description
      t.integer :quantity
      t.decimal :discount_percentage, precision: 19, scale: 2
      t.decimal :discount_flat, precision: 19, scale: 2
      t.decimal :price, precision: 19, scale: 2

      t.timestamps
    end
  end
end
