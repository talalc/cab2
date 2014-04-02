# == Schema Information
#
# Table name: favmchars
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mchar_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Favmchar < ActiveRecord::Base
  belongs_to :user
  belongs_to :mchar
end
