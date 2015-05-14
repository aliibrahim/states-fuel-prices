class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :state
      t.float :regular
      t.datetime :recorded_at

      t.timestamps null: false
    end
  end
end
