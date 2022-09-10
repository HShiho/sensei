class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :subject, null: false, default: "0"
      t.string :reply_mail, null: false, default: ""
      t.string :body, null: false, default: ""

      t.timestamps
    end
  end
end
