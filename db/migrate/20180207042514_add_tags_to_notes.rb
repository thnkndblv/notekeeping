class AddTagsToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :tags, :string, array: true, default: [], null: false
  end
end
