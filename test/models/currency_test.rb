# == Schema Information
#
# Table name: currencies
#
#  id              :integer          not null, primary key
#  country         :string
#  iso_alpha2      :string
#  iso_alpha3      :string
#  iso_numeric     :string
#  currency_name   :string
#  currency_code   :string
#  currency_symbol :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
