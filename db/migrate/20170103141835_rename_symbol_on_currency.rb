class RenameSymbolOnCurrency < ActiveRecord::Migration[5.0]
  def change
    rename_column :currencies, :symbol, :currency_symbol
  end
end
