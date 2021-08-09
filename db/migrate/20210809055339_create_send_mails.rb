class CreateSendMails < ActiveRecord::Migration[5.2]
  def change
    create_table :send_mails do |t|
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
