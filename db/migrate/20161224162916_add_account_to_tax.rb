class AddAccountToTax < ActiveRecord::Migration[5.0]
  def change
    add_reference :taxes, :account, foreign_key: true
  end
end
