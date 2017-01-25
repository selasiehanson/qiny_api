# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#  last_name       :string
#

##User class
class User < ApplicationRecord
  validates :email, uniqueness: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  has_many :account_details
  has_many :accounts, through: :account_details

  def self.from_token_payload(payload)
    find payload['sub']
  end
end
