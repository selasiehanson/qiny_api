class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :invoice_date, :due_date, :notes,
             :client_id, :currency_id,
             :invoice_number, :invoice_lines,
             :account_id, :total_amount, :total_tax,
             :status, :client, :currency

  # has_many :invoice_lines

  def client
    object.client.name
  end

  def currency
    object.currency
  end
end
