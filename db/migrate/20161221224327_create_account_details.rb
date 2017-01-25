class CreateAccountDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :account_details do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.string :role
      t.boolean :enabled

      t.timestamps
    end
  end
end
