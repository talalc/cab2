class CreateFavmchars < ActiveRecord::Migration
  def change
    create_table :favmchars, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :mchar
    end
  end
end
