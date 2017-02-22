RSpec.describe TaxesController, type: :api do
  context 'fetch taxes for an account' do
    before(:each) do
      # setup account
      @user = User.new(email: 'joe@mail.com', first_name: 'joe',
                       last_name: 'bannes', password: 'password',
                       password_confirmation: 'password')

      @account = Account.new(organization_name: 'The coffee shop')

      user_account = create_account(@user, @account)
      puts user_account
      @account_id = user_account[:account_id]
      @user_id = user_account[:user_id]
      # get token
    end

    it 'returns taxes for the current user' do
      token = valid_auth(@user_id)
      p token
      get "/#{@account_id}/taxes?page=1", headers: auth_header(token), xhr: true
      # puts last_response
      # puts json
      expect(json.count).to eq(0)
    end
  end

  def valid_auth(user_id)
    Knock::AuthToken.new(payload: { sub: user_id }).token
  end

  def auth_header(token)
    { 'Authorization' => "Bearer #{token}" }
  end

  def create_account(user, account)
    account_service = AccountService.new(user, account)
    account_service.create_account
  end
end
