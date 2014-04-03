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

require 'spec_helper'

describe Mread do

  it { should belong_to(:user) }
  it { should belong_to(:mcomic) }

end
