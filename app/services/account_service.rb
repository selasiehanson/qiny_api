class AccountService
  attr_reader :user, :account

  def initialize(user, account)
    @user = user
    @account = account
  end

  def create_account
    User.transaction do
      @user.save
      @account.created_by = @user.id
      @account.save

      user_account_detail = AccountDetail.new
      user_account_detail.user = user
      user_account_detail.account = account
      user_account_detail.role = 'admin'

      user_account_detail.save
      new_account_created(user, account, user_account_detail)
    end
 end

  private

  def new_account_created(user, account, user_account_detail)
    {
      user_id: user.id,
      account_id: account.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user_account_detail.role,
      organization_name: account.organization_name,
      created_at: user_account_detail.created_at
    }
 end
end
