class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :identifier, :secret, :redirect_uri, null: false
      t.string :authorization_endpoint, :token_endpoint, :userinfo_endpoint, null: false
      t.timestamps
    end
  end
end
