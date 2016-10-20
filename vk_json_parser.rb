require 'httparty'
require 'pry'
require 'json'
=begin
{"id"=>456239190,
 "owner_id"=>17964821,
 "artist"=>"Leighton Meester",
 "title"=>"Heartstrings",
 "duration"=>214,
 "date"=>1476646834,
 "url"=>
  "https://cs7-3v4.vk-cdn.net/p14/309c37a4f77b1b.mp3?extra=tEEUrEAgzgutbE0tZGwpGG1vX9S_9AI_SPe4X4JTNBuM_jxEZDQZyD82lxdO0pT7pjqoICPxaZUo6dC7yLhrhn7bYNph7MV8y0TjNnOwhiRs6odtZHSbRKPki1WKC46dqqiWKGRdinMc",
 "lyrics_id"=>228340887,
 "genre_id"=>2}
=end

columns = ["id", "artist", "title", "duration", "date", "url", "lyrics_id", "genre_id"]

file = File.read('music.json')
songs = JSON.parse(file)["response"]["items"]
songs.delete_at(0)

CSV.open("csv/vk_json.csv", "wb") do |csv|
  csv.add_row columns
  songs.each do |song|
    row = song.values_at(*columns).map(&:to_s)
    # binding.pry
    csv.add_row row
  end
end
# binding.pry
