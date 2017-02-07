require 'rails_helper'

RSpec.describe Admin::AccountsController, type: :api do
  # TODO: admin validation

  before do
    @account_one = Account.new(organization_name: 'the shoe shop')
    @account_two = Account.new(organization_name: 'coffee on a lounge')

    @account_one.save
    @account_two.save
  end

  it 'responds with 2 accounts' do
    get '/admin/accounts'
    expect(json['data'].count).to eq(2)
  end

  it 'returns with the accounts ordered with the last item created first in the list' do
    get '/admin/accounts'
    names = json['data'].map { |a| a['organization_name'] }
    expect(names).to eq(['coffee on a lounge', 'the shoe shop'])
  end

  it 'returns with accounts of the first page' do
    get '/admin/accounts?page=1&size=1'
    names = json['data'].map { |a| a['organization_name'] }
    expect(json['data'].count).to eq(1)
    expect(names).to eq(['coffee on a lounge'])
  end
end
