class CreateMcomics < ActiveRecord::Migration
  def change
    create_table :mcomics do |t|
      t.references :mseries, index: true
      t.integer :mevent_id
      t.string :title
      t.integer :issueNumber
      t.text :description
      t.text :text
      t.string :url
      t.string :image_path
      t.string :image_ext
      t.date :onsaleDate
      t.date :focDate
      t.date :modified
      t.timestamps
    end
  end
end
