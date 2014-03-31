require 'spec_helper'

describe Mseries do

  it { should have_many(:mcomics) }

  it { should have_many(:comments) }

end