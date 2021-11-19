class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :fulfilled
      t.timestamps
    end
  end
end
