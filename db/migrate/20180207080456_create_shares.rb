class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.references :note, foreign_key: true
      t.references :user, foreign_key: true

      t.bigint     :to_user_id,   null: false
      t.string     :permission,   null: false

      t.boolean    :active, null: false, default: true

      t.timestamps

      t.index [:note_id, :user_id, :to_user_id], unique: true
    end

    add_foreign_key :shares, :users, column: :to_user_id
    add_foreign_key :shares, :permission_types, column: :permission, primary_key: 'permission'
  end
end
