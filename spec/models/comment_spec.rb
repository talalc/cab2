# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  content          :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Comment do

  it { should belong_to(:commentable) }
  it { should belong_to(:user) }

end
