RSpec.describe AccountService do
  context 'creating an account' do
    before do
      @user = User.new(email: 'joe@mail.com', first_name: 'joe',
                       last_name: 'bannes', password: 'password',
                       password_confirmation: 'password')

      @account = Account.new(organization_name: 'The coffee shop')
    end

    it 'should create an account when given a user and account params' do
      account_service = AccountService.new(@user, @account)
      account_service.create_account

      created_user = User.find_by(email: 'joe@mail.com')
      accounts = created_user.accounts.map(&:organization_name)

      expect(accounts).to include('The coffee shop')

      expect(User.count).to eq(1)
      expect(Account.count).to eq(1)
      expect(AccountDetail.count).to eq(1)
    end

    it 'should make the user the admin of the account' do
      account_service = AccountService.new(@user, @account)
      account_service.create_account

      created_user = User.find_by(email: 'joe@mail.com')

      expect(created_user.account_details[0].role).to eq('admin')
    end
  end
end
