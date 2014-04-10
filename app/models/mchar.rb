# == Schema Information
#
# Table name: mchars
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Mchar < ActiveRecord::Base

  has_and_belongs_to_many :mcomics
  has_many :mserieses, :through => :mcomics

  has_many :favmchars
  has_many :users, :through => :favmchars

  def self.add_char(char)
    c = Mchar.new
    c.id = char["id"]
    c.name = char["name"]
    c.description = char["description"]
    c.url = char["urls"][0]["url"]
    c.image_path = char["thumbnail"]["path"]
    c.image_ext = char["thumbnail"]["extension"]
    c.modified = char["modified"].to_date
    c.save
    puts "Character #{char["name"]} added"
  end

  def image_size_incredible
    "#{self.image_path}/portrait_incredible.#{self.image_ext}"
  end

  def image_size_small
    "#{self.image_path}/portrait_small.#{self.image_ext}"
  end

end
