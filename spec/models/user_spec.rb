require 'spec_helper'

describe User do

  it { should have_many(:mreads) }
  it { should have_many(:mcomics).through(:mreads) }
  it { should have_db_column(:cc).of_type(:integer).with_options(default: 0) }

  it { should have_many(:comments) }

  it { should validate_presence_of(:nick) }
  it { should validate_numericality_of(:cc).is_greater_than_or_equal_to(0) }

  it { should have_secure_password }
  # it { should ensure_length_of(:password).is_at_least(8).is_at_most(16) }
  it { should validate_confirmation_of(:password) }


  it "must have a unique email" do
    user = User.create(nick: "talal", email: "talal@pizza.com", password: "abcd1234", password_confirmation: "abcd1234")
    expect( user ).to validate_uniqueness_of(:email)
  end

end