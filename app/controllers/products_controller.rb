class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :product_not_found
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    products = current_tenant.products.order(updated_at: :desc)
    render json: products
  end

  def show
    render json: @product
  end

  def create
    product = Product.new(product_params)
    product.account_id = current_tenant.id
    if product.save
      render json: product
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    render :head
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :product_type,
      :reorder_level,
      :can_be_purchased,
      :can_be_sold
    )
  end

  def find_product
    @product = current_tenant.products.find(params[:id])
  end

  def product_not_found
    render json: { message: "sorry couldn't find product" }, status: :bad_request
  end
end
