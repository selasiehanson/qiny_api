class Admin::AccountsController < ActionController::API
  def index
    accounts = if params[:page]
                 paged_accounts(params[:page], params[:size])
               else
                 unpaged_accounts
               end
    render json: accounts
  end

  private

  def paged_accounts(page_index, size)
    accounts = Account.order(updated_at: :desc)
                      .page(page_index).per(size)
    { data: accounts, page: page_index, total_count: accounts.count }
  end

  def unpaged_accounts
    { data: Account.order(updated_at: :desc) }
  end
end
