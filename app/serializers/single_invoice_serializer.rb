class SingleInvoiceSerializer < ActiveModel::Serializer
  attributes :id, :invoice_date, :due_date, :notes,
             :client_id, :currency_id,
             :invoice_number, :invoice_lines,
             :account_id, :total_amount, :total_tax,
             :status, :client, :currency

  has_many :invoice_lines

  def client
    object.client
  end

  def currency
    object.currency
  end

  class InvoiceLineSerializer < ActiveModel::Serializer
    attributes  :id, :invoice_id, :product_id, :description,
                :quantity, :discount_percentage, :discount_flat,
                :price, :line_total, :product

    def product
      {
        name: object.product.name,
        id: object.product_id
      }
    end
  end
end
