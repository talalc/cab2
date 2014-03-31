require 'spec_helper'

describe Mcomic do

  it { should belong_to(:mseries) }

  it { should have_many(:mreads) }
  it { should have_many(:users).through(:mreads) }

  it { should have_many(:comments) }

end