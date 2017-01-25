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

class Client < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :phone_number, presence: true, length: { is: 10 }
  validates :address, presence: true, length: { minimum: 8 }
  validates :email, uniqueness: true, email: true

  belongs_to :account
end
