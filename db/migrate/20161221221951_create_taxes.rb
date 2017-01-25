class CreateTaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :taxes do |t|
      t.string :name
      t.string :description
      t.string :text
      t.decimal :amount, precision: 5, scale: 2

      t.timestamps
    end
  end
end
