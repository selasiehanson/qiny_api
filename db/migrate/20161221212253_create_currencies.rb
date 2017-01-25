class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :country
      t.string :iso_alpha2
      t.string :iso_alpha3
      t.string :iso_numeric
      t.string :currency_name
      t.string :currency_code
      t.string :symbol

      t.timestamps
    end
  end
end
