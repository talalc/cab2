class User < ActiveRecord::Base

  has_secure_password

  validates(:email,    { :uniqueness   => { case_sensitive: false }})

  def mark_as_read(comic)

  end

end