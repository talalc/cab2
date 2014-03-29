class Mcomic < ActiveRecord::Base

  belongs_to :mseries

  def self.search_api(offset)
    ts = Time.new.strftime '%s'
    pub_key = ENV['MARVEL_PUB']
    priv_key = ENV['MARVEL_PRIV']
    hash = Digest::MD5.hexdigest( ts + priv_key + pub_key)
    response = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics?format=comic&formatType=comic&noVariants=true&limit=100&offset=#{offset.to_i*100}&apikey=#{pub_key}&hash=#{hash}&ts=#{ts}")
    results = []
    response["data"]["results"].each do |comic|
      unless Mcomic.find_by(id: comic["id"])
        unless comic["thumbnail"]["path"].include?("image_not_available")
          Mcomic.add_comic(comic)
          results << comic["id"]
        end
      end
    end
    return results
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

end