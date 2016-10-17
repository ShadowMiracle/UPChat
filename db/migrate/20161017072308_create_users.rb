class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, index: true
      t.string :email, index: true
      t.string :password_digest
      t.string :avatar_url
      t.integer :status
      t.datetime :login_time

      t.timestamps
    end
  end
end
