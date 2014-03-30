class CreateMreads < ActiveRecord::Migration
  def change
    create_table :mreads do |t|
      t.belongs_to :user
      t.belongs_to :mcomic
      t.timestamps
    end
  end
end