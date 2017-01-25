class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :accounts
  has_many :account_details
end
