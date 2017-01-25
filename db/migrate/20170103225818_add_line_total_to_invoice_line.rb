class AddLineTotalToInvoiceLine < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_lines, :line_total, :decimal, precision: 19, scale: 2
  end
end
