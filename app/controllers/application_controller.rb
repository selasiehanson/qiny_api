class ApplicationController < ActionController::API
  include Knock::Authenticable
  attr_reader :tenant
  before_action :authenticate_user
  before_action :switch_tenant

  def switch_tenant
    account = current_user.accounts.select do |ac|
      ac.id == params[:tenant_id].to_i
    end

    if account.empty?
      render :head, status: :unauthorized
    else
      @tenant = account[0]
    end
  end

  def current_tenant
    @tenant
  end
end
