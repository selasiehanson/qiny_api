# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  account_id     :integer
#  due_date       :date
#  invoice_date   :date
#  client_id      :integer
#  notes          :text
#  currency_id    :integer
#  invoice_number :string
#  total_amount   :decimal(19, 2)
#  total_tax      :decimal(19, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string
#
# Indexes
#
#  index_invoices_on_account_id   (account_id)
#  index_invoices_on_client_id    (client_id)
#  index_invoices_on_currency_id  (currency_id)
#

class Invoice < ApplicationRecord
  enum status: {
    draft: 'draft',
    approved: 'approved',
    sent: 'sent',
    unsent: 'unsent',
    paid: 'paid',
    overdue: 'overdue'
  }

  validates :invoice_date, :due_date, presence: true
  belongs_to :account
  belongs_to :client
  belongs_to :currency

  has_many :invoice_lines

  before_create :create_invoice_number

  private

  scope :by_tenant, ->(account_id) { where(account_id: account_id) }

  

  def create_invoice_number
    count = Invoice.by_tenant(account_id).count
    count_str = count.to_s.rjust(6, '0')
    self.invoice_number = "INV-#{count_str}"
  end
end
