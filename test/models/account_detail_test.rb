# == Schema Information
#
# Table name: account_details
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account_id :integer
#  role       :string
#  enabled    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_account_details_on_account_id  (account_id)
#  index_account_details_on_user_id     (user_id)
#

require 'test_helper'

class AccountDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
