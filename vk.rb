require 'vk-ruby'
require 'csv'
require 'pry'

app = VK::Application.new(version: '5.53', access_token: ENV['VK_ACCESS_TOKEN'])
songs = app.audio.get(uid: 17964821)["items"]

CSV.open("vk_songs.csv", "wb") do |csv|
  csv.add_row ["Artist", "Title", "genre_id"]
  songs.each do |song|
    row = song.values_at("artist", "title", "genre_id").map(&:to_s)
    csv.add_row row
  end
end
