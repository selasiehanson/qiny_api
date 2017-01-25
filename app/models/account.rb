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

class Account < ApplicationRecord
  validates :organization_name, length: { minimum: 3 }
  # validates :business_email, email: true, unless: proc { |a| a.email.blank? }

  has_many :taxes
  has_many :clients
  has_many :products
  has_many :invoices
end
