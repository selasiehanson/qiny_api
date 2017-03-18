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
  validate :invoice_lines_not_empty, if: -> { !invoice_lines.nil? }
  validate :absence_of_duplicate_lines, if: -> { !invoice_lines.nil? && !invoice_lines.empty? }


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

  private

  def invoice_lines_not_empty
    invoice_lines.empty? && errors.add(:invoice_lines, 'invoice must contain at least one item')
  end

  def absence_of_duplicate_lines
    total_product_count = invoice_lines.size
    uniq_product_count = invoice_lines
                         .select { |line| line[:product_id] }
                         .uniq.count
    msg = 'invoice lines contains duplicate items'
    total_product_count != uniq_product_count && errors.add(:invoice_lines, msg)
  end
end
