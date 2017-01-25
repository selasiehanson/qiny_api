# == Schema Information
#
# Table name: accounts
#
#  id                :integer          not null, primary key
#  organization_name :string
#  business_email    :string
#  created_by        :integer
#  enabled           :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
