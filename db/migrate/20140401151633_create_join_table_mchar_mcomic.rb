class CreateJoinTableMcharMcomic < ActiveRecord::Migration
  def change
    create_join_table :mchars, :mcomics do |t|
      # t.index [:mchar_id, :mcomic_id]
      # t.index [:mcomic_id, :mchar_id]
    end
  end
end
