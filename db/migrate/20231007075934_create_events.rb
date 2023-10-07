class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :customer_id, null: false
      t.integer :schedule, null: false
      t.text :description
      t.date :date, null: false

      t.timestamps
    end
  end
end
