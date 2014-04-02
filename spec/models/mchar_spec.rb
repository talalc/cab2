require 'spec_helper'

describe Mchar do

  it { should have_and_belong_to_many(:mcomics) }

  it { should have_many(:favmchars) }
  it { should have_many(:users).through(:favmchars) }

end