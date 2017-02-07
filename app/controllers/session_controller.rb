class SessionController < ApplicationController
  skip_before_action :authenticate_user
  skip_before_action :switch_tenant

  def register
    user = User.new(user_params)
    account = Account.new(account_params)
    if user.valid? && account.valid?
      render json: create_account(user, account), status: :created
    else
      render json: get_registration_errors(user, account), status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.fetch(:credentials, {}).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def account_params
    params.fetch(:credentials, {).permit(:organization_name)
  end

  def create_account(user, account)
    account_service = AccountService.new(user, account)
    account_service.create_account
  end

  def get_registration_errors(user, account)
    if !user.valid? && !account.valid?
      user.errors.messages.merge(account.errors.messages)
    elsif !user.valid?
      user.errors.messages
    elsif !account.valid?
      account.errors.messages
    end
  end
end
