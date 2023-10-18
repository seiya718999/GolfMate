class DropChats < ActiveRecord::Migration[6.1]
  def up
    drop_table :chats
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end