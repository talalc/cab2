# == Schema Information
#
# Table name: mcomics
#
#  id          :integer          not null, primary key
#  mseries_id  :integer
#  mevent_id   :integer
#  title       :string(255)
#  issueNumber :integer
#  description :text
#  text        :text
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  onsaleDate  :date
#  focDate     :date
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Mcomic do

  it { should belong_to(:mseries) }

  it { should have_and_belong_to_many(:mchars) }

  it { should have_many(:mreads) }
  it { should have_many(:users).through(:mreads) }

  it { should have_many(:comments) }

end
