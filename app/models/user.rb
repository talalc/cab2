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

  has_attached_file :profile, :styles => { :medium => "300x300#", :small => "100x100#", :thumb => "64x64#" },
                    :default_url => "/:attachment/:style/missing.png",
                    :url  => "/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"


  validates_attachment_size :profile, :less_than => 5.megabytes
  validates_attachment_content_type :profile, :content_type => ['image/jpeg', 'image/jpg', 'image/png']

  has_many :mreads
  has_many :mcomics, :through => :mreads

  has_many :favmchars
  has_many :mchars, :through => :favmchars

  has_many :comments

  validates(:nick,     { :presence     => true })
  validates(:email,    { :uniqueness   => { case_sensitive: false }})
  validates(:cc,  { :numericality => { :greater_than_or_equal_to => 0 }})

  def mark_as_mread(mcomic)
    self.cc += 100
    mread = Mread.new
    mread.user = self
    mread.mcomic = mcomic
    return self.save && mread.save
  end

  def favorite_mchar(mchar)
    self.cc += 500
    favchar = Favmchar.new
    favchar.user = self
    favchar.mchar = mchar
    return self.save && favchar.save
  end

  def read?(comic)
    mreads.find_by(mcomic_id: comic.id)
  end

end
