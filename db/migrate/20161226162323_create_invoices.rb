class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :account, foreign_key: true
      t.datetime :due_date
      t.datetime :invoice_date
      t.references :client, foreign_key: true
      t.text :notes
      t.references :currency, foreign_key: true
      t.string :invoice_number
      t.decimal :total_amount, precision: 19, scale: 2
      t.decimal :total_tax, precision: 19, scale: 2

      t.timestamps
    end
  end
end
