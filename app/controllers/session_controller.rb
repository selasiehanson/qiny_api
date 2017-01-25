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
    params.require(:credentials).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def account_params
    params.require(:credentials).permit(:organization_name)
  end

  # Wrap in transaction if possible
  def create_account(user, account)
    User.transaction do
      user.save
      account.created_by = user.id
      account.save

      user_account_detail = AccountDetail.new
      user_account_detail.user = user
      user_account_detail.account = account
      user_account_detail.role = 'admin'

      user_account_detail.save
      {
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        role: user_account_detail.role,
        organization_name: account.organization_name,
        created_at: user_account_detail.created_at
      }
    end
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
