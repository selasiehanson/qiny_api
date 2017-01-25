# == Route Map
#
#     Prefix Verb   URI Pattern                        Controller#Action
#   register POST   /register(.:format)                session#register
# user_token POST   /user_token(.:format)              user_token#create
# currencies GET    /currencies(.:format)              currencies#index
#            POST   /currencies(.:format)              currencies#create
#   currency GET    /currencies/:id(.:format)          currencies#show
#            PATCH  /currencies/:id(.:format)          currencies#update
#            PUT    /currencies/:id(.:format)          currencies#update
#            DELETE /currencies/:id(.:format)          currencies#destroy
#    clients GET    /:tenant_id/clients(.:format)      clients#index
#            POST   /:tenant_id/clients(.:format)      clients#create
#     client GET    /:tenant_id/clients/:id(.:format)  clients#show
#            PATCH  /:tenant_id/clients/:id(.:format)  clients#update
#            PUT    /:tenant_id/clients/:id(.:format)  clients#update
#            DELETE /:tenant_id/clients/:id(.:format)  clients#destroy
#   products GET    /:tenant_id/products(.:format)     products#index
#            POST   /:tenant_id/products(.:format)     products#create
#    product GET    /:tenant_id/products/:id(.:format) products#show
#            PATCH  /:tenant_id/products/:id(.:format) products#update
#            PUT    /:tenant_id/products/:id(.:format) products#update
#            DELETE /:tenant_id/products/:id(.:format) products#destroy
#      taxes GET    /:tenant_id/taxes(.:format)        taxes#index
#            POST   /:tenant_id/taxes(.:format)        taxes#create
#        tax GET    /:tenant_id/taxes/:id(.:format)    taxes#show
#            PATCH  /:tenant_id/taxes/:id(.:format)    taxes#update
#            PUT    /:tenant_id/taxes/:id(.:format)    taxes#update
#            DELETE /:tenant_id/taxes/:id(.:format)    taxes#destroy
#

Rails.application.routes.draw do
  get '/accounts/profile' => 'accounts#profile'
  post 'register', as: :register, to: 'session#register'
  post 'user_token' => 'user_token#create'

  resources :currencies

  scope '/:tenant_id' do
    resources :clients
    resources :products
    resources :taxes
    resources :invoices
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
