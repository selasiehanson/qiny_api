RSpec.describe SessionController, type: :api do
  context 'Registering a new account' do
    context 'When user details are valid' do
      before do
        payload = { first_name: 'billy', last_name: 'strong',
                    email: 'bils@mail.com', organization_name: 'The blue fountain',
                    password: 'password', password_confirmation: 'password' }
        post '/register', credentials: payload
      end

      it 'should create a successful reponse' do
        expect(last_response.status).to eq(201)
      end

      it 'should create a new account with user and account set and linked' do
        expect(json['acount_id']).not_to eq(0)
        expect(json['user_id']).not_to eq(0)
      end
    end

    context 'When parameters are invalid' do
      before do
        post '/register', credentials: {}
      end

      it 'should return validation errors' do
        expect(last_response.status).to eq(422)
        expect(json.keys).to include('email', 'first_name', 'last_name',
                                     'password', 'organization_name')
        expect(json).not_to be_empty
      end
    end
  end
end
