require 'spec_helper'

describe Favmchar do

  it { should belong_to(:user) }
  it { should belong_to(:mchar) }

end