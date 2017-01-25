class ChangeColumnTypesForDueDateAndInvoiceDate < ActiveRecord::Migration[5.0]
  def change
    change_column :invoices, :due_date, :date
    change_column :invoices, :invoice_date, :date
  end
end
