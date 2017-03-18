RSpec.describe InvoicesController, type: :api do
  before(:each) do
    @user = User.new(
      email: 'joe@mail.com', first_name: 'joe',
      last_name: 'bannes', password: 'password',
      password_confirmation: 'password'
    )

    @account = Account.new(organization_name: 'The coffee shop')

    user_account = create_account(@user, @account)
    @account_id = user_account[:account_id]

    @user_id = user_account[:user_id]
    @products = create_products(@account_id, 10, 'sample')

  end

  context 'POST Invoice' do
    context 'When invoice data is valid' do
      before do
        url = "#{@account_id}/invoices"
        token = valid_auth(@user_id)

        date_format = '%Y/%m/%d'
        invoice_date = Date.today.strftime(date_format)
        data = {
          invoice_date: invoice_date,
          currency_id: create_currency.id,
          client_id: create_client(@account_id).id,
          due_date:  1.days.from_now.strftime(date_format),
          invoice_lines: create_invoice_lines(@products)
        }

        post url, { invoice: data }, auth_header(token)
      end

      it 'creates an invoice' do
        expect(json[':id']).not_to eq(0)
        expect(last_response.status).to eq(200)
      end
    end
  end

  def create_account(user, account)
    account_service = AccountService.new(user, account)
    account_service.create_account
  end

  def create_products(account_id, count, product_name)
    (1..count).map do |i|
      params = {
        name: "#{product_name}-#{i + 1}",
        account_id: account_id,
        description: 'a nice product',
        product_type: 'consumable',
        reorder_level: 10
      }
      Product.create(params)
    end
  end

  def create_invoice_lines(products)
    products.map(&:id).map do |id|
      {
        quantity: 2,
        product_id: id,
        price: 300,
        description: 'a nice product',
        discount_flat: 0,
        discount_percentage: 0
      }
    end
  end

  def create_currency
    Currency.create!(
      country: 'United States of America',
      iso_alpha2: 'US',
      iso_alpha3: 'USA',
      iso_numeric: '123',
      currency_name: 'United State Dollar',
      currency_code: '111',
      currency_symbol: '$'
    )
  end

  def create_client(account_id)
    Client.create!(
      account_id: account_id,
      name: 'Peter Brown',
      phone_number: '1112323423',
      address: '123 street name',
      email: 'petebr@mail.com'
    )
  end
end
