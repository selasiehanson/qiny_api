# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  text             :string
#  product_type     :string
#  reorder_level    :integer
#  can_be_sold      :boolean
#  can_be_purchased :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :integer
#
# Indexes
#
#  index_products_on_account_id  (account_id)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
