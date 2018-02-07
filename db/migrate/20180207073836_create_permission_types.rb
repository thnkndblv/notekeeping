class CreatePermissionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :permission_types, id: :string, primary_key: 'permission' do |t|

      t.timestamps
    end
  end
end
