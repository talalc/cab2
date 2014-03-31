# == Schema Information
#
# Table name: mreads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mcomic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Mread < ActiveRecord::Base
  belongs_to :user
  belongs_to :mcomic
end
