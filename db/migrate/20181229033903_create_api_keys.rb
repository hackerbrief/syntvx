class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
    add_index :api_keys, :token, unique: true
  end
end
