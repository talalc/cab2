require 'spec_helper'

describe Mread do

  it { should belong_to(:user) }
  it { should belong_to(:mcomic) }

end