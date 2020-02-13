class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body, null: false, default: ''
      t.references :admin_user, foreign_key: true
      t.bigint :receiver_id

      t.timestamps
    end
  end
end
