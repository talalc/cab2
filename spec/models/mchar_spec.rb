# == Schema Information
#
# Table name: mchars
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Mchar do

  it { should have_and_belong_to_many(:mcomics) }

  it { should have_many(:mserieses).through(:mcomics) }

  it { should have_many(:favmchars) }
  it { should have_many(:users).through(:favmchars) }

end
