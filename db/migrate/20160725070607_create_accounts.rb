class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :identifier, null: false
      t.string :name, :email
      t.timestamps
    end
  end
end
