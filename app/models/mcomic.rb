# == Schema Information
#
# Table name: mcomics
#
#  id          :integer          not null, primary key
#  mseries_id  :integer
#  mevent_id   :integer
#  title       :string(255)
#  issueNumber :integer
#  description :text
#  text        :text
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  onsaleDate  :date
#  focDate     :date
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Mcomic < ActiveRecord::Base

  belongs_to :mseries

  has_and_belongs_to_many :mchars

  has_many :mreads
  has_many :users, :through => :mreads

  has_many :comments, as: :commentable

  def self.search_api(offset)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics?format=comic&formatType=comic&noVariants=true&limit=100&offset=#{offset.to_i*100}&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    results = []
    response["data"]["results"].each do |comic|
      unless Mcomic.find_by(id: comic["id"])
        Mcomic.add_comic(comic)
        results << comic["id"]
      end
    end
    return results
  end

  def self.retrieve_comic(mcomic_id)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics/#{mcomic_id}?&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    response["data"]["results"].each do |comic|
      Mcomic.add_comic(comic)
    end
  end

  def self.add_comic(comic)
    c = Mcomic.new
    c.id = comic["id"]
    c.mseries_id = comic["series"]["resourceURI"].split('/')[6].to_i
    c.title = comic["title"]
    c.issueNumber = comic["issueNumber"]
    c.description = comic["description"]
    # c.text ||= comic["textObjects"].first["text"]
    c.url = comic["urls"][0]["url"]
    c.image_path = comic["thumbnail"]["path"]
    c.image_ext = comic["thumbnail"]["extension"]
    c.onsaleDate = comic["dates"][0]["date"]
    c.focDate = comic["dates"][1]["date"]
    c.modified = comic["modified"]
    c.save
    puts "Comic #{comic["title"]} added"
  end

  def self.add_comic_chars(comic)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics/#{comic.id}/characters?limit=100&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    response["data"]["results"].each do |char|
      unless Mchar.find_by(id: char["id"])
        Mchar.add_char(char)
      end
      unless comic.mchars.find_by(id: char["id"])
        comic.mchars << Mchar.find_by(id: char["id"])
      end
    end
  end

  # def self.search_api_cache(offset)
  #   ts = Time.new.strftime '%s'
  #   hash = Digest::MD5.hexdigest( ts + ENV['MARVEL_PUB'] + ENV['MARVEL_PRIV'])
  #   url = "http://gateway.marvel.com:80/v1/public/comics"
  #   Rails.cache.fetch("offset", :expires_in => 60.seconds) do
  #     HTTParty.get("http://gateway.marvel.com:80/v1/public/comics?format=comic&formatType=comic&noVariants=true&limit=100&offset=1200&apikey=#{ENV['MARVEL_PUB']}&hash=#{hash}&ts=#{ts}")
  #   end
  #   binding.pry
  #   response["data"]["results"].each do |comic|
  #     unless Mcomic.find_by(id: comic["id"])
  #       unless comic["thumbnail"]["path"].include?("image_not_available")
  #         Mcomic.add_comic(comic)
  #         results << comic["id"]
  #       end
  #     end
  #   end
  #   return results
  # end

end
