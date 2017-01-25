class CurrenciesController < ApplicationController
  skip_before_action :switch_tenant

  def index
    render json: Currency.all
  end
end
