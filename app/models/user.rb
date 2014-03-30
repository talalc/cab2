class User < ActiveRecord::Base

  has_secure_password

  has_many :mreads
  has_many :mcomics, :through => :mreads

  has_many :comments, as: :commentable

  validates(:email,    { :uniqueness   => { case_sensitive: false }})

  def mark_as_mread(mcomic)
    self.cc += 100
    mread = Mread.new
    mread.user = self
    mread.mcomic = mcomic
    return self.save && mread.save
  end

end