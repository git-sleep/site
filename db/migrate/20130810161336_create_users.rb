class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :xid
      t.string :token
      t.string :first_name
      t.string :last_name
      t.string :photo

      t.timestamps
    end
  end
end
