class InvoiceService
  def self.save_invoice(invoice)
    invoice.total_amount = compute_total_amount(invoice.invoice_lines)
    invoice.total_tax = compute_total_tax(invoice.invoice_lines)
    invoice.status = :draft
    invoice.invoice_lines.map do |line|
      compute_line_total(line)
    end
    invoice.save
    invoice
  end

  private

  def self.update_invoice_lines
    lines.each do |line|
      if id
        compute_line_total(line)
        line.save
      else
        line_attrs = line.build(@invoice.id)
        compute_line_total(line_attrs)
        InvoiceLine.create(line_attrs)
      end
    end
  end

  def self.compute_total_amount(lines)
    lines.inject(0) do |result, line|
      result + (line.quantity.to_f * line.price.to_f)
    end
  end

  def self.compute_total_tax(lines)
    lines.inject(0) do
      # /result + line.tax.to_f
      0
    end
  end

  def self.save_line(line_attributes)
    if id
      line = InvoiceLine.find(id)
      line.update(line_attributes)
    else
      InvoiceLine.create(line_attributes)
    end
  end

  def self.compute_line_total(line)
    line.line_total = line.quantity.to_f * line.price.to_f
  end
end
