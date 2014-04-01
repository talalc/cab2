class Mchar < ActiveRecord::Base

  has_and_belongs_to_many :mcomics

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
    c.modified = char["modified"]
    c.save
    puts "Character #{char["name"]} added"
  end

end