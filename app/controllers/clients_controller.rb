class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :client_not_found
  before_action :find_client, only: [:show, :update, :destroy]

  def index
    result = if !params[:page].nil?
               paged_clients(params[:page], params[:size])
             else
               unpaged_clients
             end
    render json: result
  end

  def show
    render json: @client
  end

  def create
    client = Client.new(client_params)
    client.account_id = current_tenant.id
    if client.save
      render json: client
    else
      render json: client.errors, status: :bad_request
    end
  end

  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :bad_request
    end
  end

  def destroy
    @client.destroy
    render :head
  end

  private

  def paged_clients(page_index, size)
    query = current_tenant
            .clients.order(updated_at: :desc)

    clients = query
              .page(page_index).per(size)
    { data: clients, meta: { page: page_index, total_count: query.count } }
  end

  def unpaged_clients
    clients = current_tenant
              .clients.order(updated_at: :desc)
    { data: clients }
  end

  def client_params
    params.require(:client).permit(:name, :email, :phone_number, :address)
  end

  def find_client
    @client = current_tenant.clients.find(params[:id])
  end

  def client_not_found
    render json: { message: "sorry couldn't find client" }, status: :bad_request
  end
end
