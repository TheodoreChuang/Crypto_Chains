class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :content
      t.string :source
      t.date :source_date
      t.integer :views
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
