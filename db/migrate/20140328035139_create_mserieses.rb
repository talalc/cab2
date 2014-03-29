class CreateMserieses < ActiveRecord::Migration
  def change
    create_table :mserieses do |t|
      t.string :title
      t.text :description
      t.integer :startYear
      t.integer :endYear
      t.string :url
      t.string :image_path
      t.string :image_ext
      t.date :modified
      t.timestamps
    end
  end
end
