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

class Currency < ApplicationRecord
end
