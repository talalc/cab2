# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  cc              :integer          default(0)
#  nick            :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  has_secure_password

  has_many :mreads
  has_many :mcomics, :through => :mreads

  has_many :comments

  validates(:email,    { :uniqueness   => { case_sensitive: false }})

  def mark_as_mread(mcomic)
    self.cc += 100
    mread = Mread.new
    mread.user = self
    mread.mcomic = mcomic
    return self.save && mread.save
  end

end
