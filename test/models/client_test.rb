# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  phone_number :string
#  address      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#
# Indexes
#
#  index_clients_on_account_id  (account_id)
#

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
