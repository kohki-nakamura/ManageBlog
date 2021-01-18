class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.boolean :is_public, null: false, default: false
      t.text :content, null: false
      t.string :image

      t.timestamps
    end
  end
end
