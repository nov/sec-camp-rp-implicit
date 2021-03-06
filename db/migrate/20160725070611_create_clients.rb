class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :identifier, :secret, :redirect_uri, null: false
      t.string :issuer, null: false
      t.timestamps
    end
  end
end
