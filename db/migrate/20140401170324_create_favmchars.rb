class CreateFavmchars < ActiveRecord::Migration
  def change
    create_table :favmchars do |t|
      t.belongs_to :user
      t.belongs_to :mchar
      t.timestamps
    end
  end
end
