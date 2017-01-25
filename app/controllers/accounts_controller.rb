class AccountsController < ApplicationController
  skip_before_action :switch_tenant

  def profile
    render json: current_user, serializer: ProfileSerializer
  end
end
