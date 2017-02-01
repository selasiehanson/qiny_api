class CurrenciesController < ApplicationController
  skip_before_action :switch_tenant

  def index
    render json: Currency.where.not(currency_code: nil)
  end
end
