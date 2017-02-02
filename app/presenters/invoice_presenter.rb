class InvoicePresenter
  include ActiveModel::Model

  attr_accessor :invoice_date, :due_date, :notes,
                :client_id, :currency_id,
                :invoice_number, :invoice_lines,
                :account_id, :id, :total_amount, :total_tax

  validates :invoice_lines, presence: true
  validate :valid_due_date
  validate :valid_invoice_date
  validate :invoice_lines_not_empty, if: -> { !invoice_lines.nil? }
  validate :absence_of_duplicate_lines, if: -> { !invoice_lines.nil? && !invoice_lines.empty? }

  def save
    if id
      update_invoice
    else
      create_invoice
    end
  end

  private

  def create_invoice
    Invoice.transaction do
      @invoice = Invoice.create!(invoice_attributes)
      lines = invoice_lines.map { |line| LinePresenter.new(line) }
      @invoice.total_amount = compute_total_amount(lines)
      @invoice.total_tax = compute_total_tax(lines)
      @invoice.save
      attached_lines = lines.map { |l| l.build(@invoice.id) }
      InvoiceLine.create!(attached_lines)
      @invoice.id
    end
  end

  def update_invoice
    Invoice.transaction do
      @invoice = Invoice.find(id)
      lines = invoice_lines.map { |line| LinePresenter.new(line) }
      @invoice.total_amount = compute_total_amount(lines)
      @invoice.total_tax = compute_total_tax(lines)
      @invoice.update_attributes(invoice_attributes)
      # TODO: handle deleted items;

      lines.each do |line|
        if id
          line.save
        else
          line_attrs = line.build(@invoice.id)
          InvoiceLine.create(line_attrs)
        end
      end
      @invoice.id
    end
  end

  def compute_total_amount(lines)
    lines.inject(0) do |result, line|
      result + (line.quantity.to_f * line.price.to_f)
    end
  end

  def compute_total_tax(lines)
    lines.inject(0) do
      # /result + line.tax.to_f
      0
    end
  end

  def valid_due_date
    parsed_date = nil
    begin
      parsed_date = Date.strptime(due_date, '%m/%d/%Y')
    rescue
      errors.add(:due_date,
                 'inavalid date format, date must be in the format mm/dd/yyyy format')
      return
    end
    parsed_date < Date.today && errors.add(:due_date,
                                           "due date cannot be today's date' or earlier")
  end

  def valid_invoice_date
    parsed_date = nil
    begin
      parsed_date = Date.strptime(invoice_date, '%m/%d/%Y')
    rescue
      errors.add(:invoice_date, 'inavalid date format, date must be in the format mm/dd/yyyy format')
      return
    end
    parsed_date < Date.today && errors.add(:invoice_date, "invoice date cannot be today's date' or earlier")
  end

  def invoice_lines_not_empty
    invoice_lines.empty? && errors.add(:invoice_lines, 'invoice must contain at least one item')
  end

  def absence_of_duplicate_lines
    total_product_count = invoice_lines.count
    uniq_product_count = invoice_lines
                         .select { |line| line[:product_id] }
                         .uniq.count
    msg = 'invoice lines contains duplicate items'
    total_product_count != uniq_product_count && errors.add(:invoice_lines, msg)
  end

  def convert_to_date(date)
    Date.strptime(date, '%m/%d/%Y')
  end

  def invoice_attributes
    {
      client_id: client_id,
      due_date: convert_to_date(due_date),
      invoice_date: convert_to_date(invoice_date),
      currency_id: currency_id,
      invoice_number: invoice_number,
      notes: notes,
      status: :draft,
      account_id: account_id
    }
  end
end

class LinePresenter
  include ActiveModel::Model

  attr_accessor :invoice_id, :product_id, :description,
                :quantity, :discount_percentage,
                :discount_flat, :price, :id

  validates :quantity, presence: true
  validates :price, presence: true
  validates :description, presence: true

  def build(invoice_id)
    line_attributes.merge(invoice_id: invoice_id)
  end

  def save
    if id
      line = InvoiceLine.find(id)
      line.update(line_attributes)
    else
      InvoiceLine.create(line_attributes)
    end
  end

  def line_attributes
    {
      product_id: product_id,
      description: description,
      quantity: quantity,
      discount_percentage: discount_percentage,
      discount_flat: discount_flat,
      price: price,
      id: id
    }
  end
end
