class InvoicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invoice_not_found

  before_action :find_invoice, only: [:show, :update]

  def index
    result = if !params[:page].nil?
               paged_invoices(params[:page], params[:size])
             else
               unpaged_invoices
             end
    render json: result[:data], meta: result[:meta]
  end

  def show
    render json: @invoice, serializer: SingleInvoiceSerializer
  end

  def create
    attrs = invoice_params.merge(account_id: current_tenant.id)
    invoice = Invoice.new(attrs)
    invoice.invoice_lines.build(invoice_lines_params[:invoice_lines])
    if invoice.valid?
      saved_invoice = InvoiceService.save_invoice(invoice)
      render json: saved_invoice,
             serializer: SingleInvoiceSerializer, status: :ok
    else
      render json: invoice.errors.messages,
             status: :unprocessable_entity
    end
  end

  def update
    create_or_update(params[:id])
  end

  private

  def paged_invoices(page_index, size)
    query = current_tenant
            .invoices
            .includes(:invoice_lines)
            .order(updated_at: :desc)

    invoices = query
               .page(page_index).per(size)

    { data: invoices, meta: { page: page_index, total_count: query.count } }
  end

  def unpaged_invoices
    invoices = current_tenant
               .invoices
               .includes(:invoice_lines).order(updated_at: :desc)
    { data: invoices }
  end

  def create_or_update(_id = 0)
    attrs = invoice_params.merge(account_id: current_tenant.id)
    invoice_presenter = InvoicePresenter.new(attrs)
    if invoice_presenter.valid?
      if id.zero?
        invoice_id = InvoiceService.create_invoice(invoice_presenter)
      else
        invoice_id = InvoiceService.update_invoice(invoice_presenter)
      end
      saved_invoice = current_tenant.invoices.find(invoice_id)
      render json: saved_invoice,
             serializer: SingleInvoiceSerializer, status: :ok
    else
      render json: invoice_presenter.errors.messages,
             status: :unprocessable_entity
    end
  end

  def invoice_params
    params.require(:invoice)
          .permit(:invoice_date, :due_date, :notes, :client_id, :currency_id,
                  :invoice_number, :id)
  end

  def invoice_lines_params
    params.require(:invoice)
          .permit(invoice_lines: [:invoice_id, :product_id, :quantity, :id, :description,
                                  :discount_percentage, :discount_flat, :price])
  end

  def find_invoice
    @invoice = current_tenant.invoices.find(params[:id])
  end

  def invoice_not_found
    render json: { message: "sorry couldn't find invoice" }, status: :bad_request
  end
end
