class TaxesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :tax_not_found
  before_action :find_tax, only: [:show, :update, :destroy]

  def index
    taxes = current_tenant.taxes.order(updated_at: :desc)
    render json: taxes
  end

  def show
    render json: @tax
  end

  def create
    tax = Tax.new(tax_params)
    tax.account_id = current_tenant.id
    if tax.save
      render json: tax
    else
      render json: tax.errors, status: :bad_request
    end
  end

  def update
    if @tax.update(tax_params)
      render json: @tax
    else
      render json: @tax.errors, status: :bad_request
    end
  end

  def destroy
    @tax.destroy
    render :head
  end

  private

  def tax_params
    params.require(:tax).permit(:name, :description, :amount)
  end

  def find_tax
    @tax = current_tenant.taxes.find(params[:id])
  end

  def tax_not_found
    render json: { message: "sorry couldn't find tax" }, status: :bad_request
  end
end
