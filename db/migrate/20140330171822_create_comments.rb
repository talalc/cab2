class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.references :commentable, polymorphic: true
      t.text :content
      t.timestamps
    end
  end
end