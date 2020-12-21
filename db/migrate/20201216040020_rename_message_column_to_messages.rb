class RenameMessageColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    rename_column :messages, :message, :message_content
  end
end
