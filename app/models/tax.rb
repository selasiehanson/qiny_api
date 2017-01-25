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

class Tax < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { minimum: 3 }

  belongs_to :account
end
