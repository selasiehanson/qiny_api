# == Schema Information
#
# Table name: invoice_lines
#
#  id                  :integer          not null, primary key
#  invoice_id          :integer
#  product_id          :integer
#  description         :text
#  quantity            :integer
#  discount_percentage :decimal(19, 2)
#  discount_flat       :decimal(19, 2)
#  price               :decimal(19, 2)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  line_total          :decimal(19, 2)
#
# Indexes
#
#  index_invoice_lines_on_invoice_id  (invoice_id)
#  index_invoice_lines_on_product_id  (product_id)
#

class InvoiceLine < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: {
    greater_than_or_equal: 0, less_than_or_equal_to: 100
  }
  validates :discount_flat, numericality: { greater_than_or_equal: 0 }
  validates :price, numericality: { greater_than: 0 }

  belongs_to :invoice
  belongs_to :product

  before_save :compute_line_total

  private

  def compute_line_total
    self.line_total = quantity * price
  end
end
