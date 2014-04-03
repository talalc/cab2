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

require 'spec_helper'

describe Favmchar do

  it { should belong_to(:user) }
  it { should belong_to(:mchar) }

end
