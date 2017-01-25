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

class AccountDetail < ApplicationRecord
  validates :role, presence: true
  validate :valid_role

  belongs_to :user
  belongs_to :account

  def valid_role
    roles = %w(admin cashier)
    error_message = "role must be one of the following #{roles}"
    unless roles.include?(role)
      errors.add(:role, error_message)
    end
  end
end
