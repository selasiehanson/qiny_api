RSpec.describe TaxesController, type: :api do
  # do validation
  # return user
  # create account in setup
  # create taxes for account

  def valid_auth
    @user = users(:one)
    @token = Knock::AuthToken.new(payload: { sub: @user.id }).token
    @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token}"
 end
end
