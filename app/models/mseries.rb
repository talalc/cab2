class Mseries < ActiveRecord::Base

  has_many :mcomics

  def self.search_api(string)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/series?title=#{string}&contains=comic&limit=100&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    results = []
    response["data"]["results"].each do |series|
      unless Mseries.find_by(id: series["id"])
        unless series["thumbnail"]["path"].include?("image_not_available")
          Mseries.add_series(series)
          results << series["id"]
        end
      end
    end
    return results
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

end