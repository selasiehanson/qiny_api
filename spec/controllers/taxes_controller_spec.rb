RSpec.describe TaxesController, type: :api do
  context 'taxes for an account:' do
    before(:each) do
      # setup account
      @user = User.new(email: 'joe@mail.com', first_name: 'joe',
                       last_name: 'bannes', password: 'password',
                       password_confirmation: 'password')

      @account = Account.new(organization_name: 'The coffee shop')

      user_account = create_account(@user, @account)
      @account_id = user_account[:account_id]
      @user_id = user_account[:user_id]
    end

    it 'returns no taxes for the current users account' do
      token = valid_auth(@user_id)
      url = "/#{@account_id}/taxes?page=1"
      get url, {}, auth_header(token)
      expect(json['total_count']).to eq(0)
    end

    it 'create and returns 1 tax' do
      url = "/#{@account_id}/taxes?page=1"
      token = valid_auth(@user_id)
      tax_data = { tax:
        {
          name: 'VAT',
          amount: '17.5', description: 'National health insurance levy'
        } }

      post url, tax_data, auth_header(token)

      expect(json['id']).to be_present
    end
  end

  def create_account(user, account)
    account_service = AccountService.new(user, account)
    account_service.create_account
  end
end
