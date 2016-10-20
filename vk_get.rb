require 'vk-ruby'
require 'csv'
require 'pry'

app = VK::Application.new(version: '5.53', access_token: ENV['VK_ACCESS_TOKEN'])
songs = app.audio.get(uid: 17964821)["items"]
# binding.pry
CSV.open("csv/vk_songs3.csv", "wb") do |csv|
  # csv.add_row ["id", "Artist", "Title"]
  songs.each do |song|
    row = song.values_at("id", "artist", "title").map(&:to_s)
    csv.add_row row
  end
end
