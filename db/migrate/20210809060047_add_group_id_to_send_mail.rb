class AddGroupIdToSendMail < ActiveRecord::Migration[5.2]
  def change
    add_column :send_mails, :group_id, :integer
  end
end
