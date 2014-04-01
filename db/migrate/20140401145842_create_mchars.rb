class CreateMchars < ActiveRecord::Migration
  def change
    create_table :mchars do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :image_path
      t.string :image_ext
      t.date :modified
      t.timestamps
    end
  end
end
