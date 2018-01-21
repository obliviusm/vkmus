require_relative '../require_all_helper'

NAME = 'misha'
SOURCE_NAME = "#{NAME}/grace"

reader = Adapter::CsvReader.new(SOURCE_NAME)
song = reader.get_lines[4]

artist_title = song["artist"] + " " + song["title"]
response = HTTParty.get("https://api.deezer.com/search/track?q=#{artist_title}")

# puts response.body, response.code, response.message, response.headers.inspect
# binding.pry
# puts JSON.parse(response.body)["data"].map { |track| track["artist"]["name"] }
# p response.message
track = JSON.parse(response.body)["data"][0]
puts track
puts [track["title"], track["artist"]["name"]]
