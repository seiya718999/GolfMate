class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :group, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
