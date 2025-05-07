class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :link_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, :link_id
  end
end
