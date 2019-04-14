class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false, unique: true
      t.text :text, null: false

      t.timestamps
    end
    add_index :articles, :title, unique: true
  end
end
