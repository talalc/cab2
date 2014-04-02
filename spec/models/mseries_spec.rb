# == Schema Information
#
# Table name: mserieses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  startYear   :integer
#  endYear     :integer
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Mseries do

  it { should have_many(:mcomics) }
  it { should have_many(:mchars).through(:mcomics) }
  it { should have_many(:comments) }

end
