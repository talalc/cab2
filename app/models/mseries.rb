# == Schema Information
#
# Table name: mserieses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  startYear   :integer
#  endYear     :integer
#  url         :string(255)
#  image_path  :string(255)
#  image_ext   :string(255)
#  modified    :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Mseries < ActiveRecord::Base

  has_many :mcomics
  has_many :mchars, :through => :mcomics

  has_many :comments, as: :commentable


  def self.search_api(string)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/series?title=#{string}&contains=comic&limit=100&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    results = []
    response["data"]["results"].each do |series|
      unless Mseries.find_by(id: series["id"])
        Mseries.add_series(series)
        results << series["id"]
      end
    end
    return results
  end

  def self.retrieve_series(mseries_id)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/series/#{mseries_id.to_i}?&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    response["data"]["results"].each do |series|
      Mseries.add_series(series)
    end
  end

  def self.add_series(series)
    s = Mseries.new
    s.id = series["id"]
    s.title = series["title"]
    s.description = series["description"]
    s.startYear = series["startYear"]
    s.endYear = series["endYear"]
    s.url = series["urls"][0]["url"]
    s.image_path = series["thumbnail"]["path"]
    s.image_ext = series["thumbnail"]["extension"]
    s.modified = series["modified"]
    s.save
    puts "Series #{series["title"]} added"
  end

  def self.add_series_comics(series)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/series/#{series.id}/comics?format=comic&formatType=comic&noVariants=true&orderBy=onsaleDate&limit=100&offset=0&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    response["data"]["results"].each do |comic|
      unless Mcomic.find_by(id: comic["id"])
        Mcomic.add_comic(comic)
      end
    end
  end


end
