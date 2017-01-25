# == Schema Information
#
# Table name: taxes
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  text        :string
#  amount      :decimal(5, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :integer
#
# Indexes
#
#  index_taxes_on_account_id  (account_id)
#

require 'test_helper'

class TaxTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
