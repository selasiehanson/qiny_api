class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :organization_name
      t.string :business_email
      t.integer :created_by
      t.boolean :enabled

      t.timestamps
    end
  end
end
