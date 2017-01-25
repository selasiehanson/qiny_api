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

require 'test_helper'

class InvoiceLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
