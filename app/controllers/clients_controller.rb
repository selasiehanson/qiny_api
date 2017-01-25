class ClientsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :client_not_found
  before_action :find_client, only: [:show, :update, :destroy]

  def index
    clients = current_tenant.clients.order(created_at: :desc)
    render json: clients
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

  def client_params
    params.require(:client).permit(:name, :email,:phone_number, :address)
  end

  def find_client
    @client = current_tenant.clients.find(params[:id])
  end

  def client_not_found
    render json: { message: "sorry couldn't find client" }, status: :bad_request
  end
end
