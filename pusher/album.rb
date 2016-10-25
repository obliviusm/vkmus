require_relative '../require_all_helper'

SOURCE_NAME = "output/filter/genre/60's_rock"
ALBUM_TITLE = "60s Rock"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines
song_ids = songs.map{ |s| s["id"] }.join(",")
# p song_ids

app = VK::Application.new(version: '5.53', access_token: ENV['VK_ACCESS_TOKEN'])
new_album_id = app.audio.addAlbum(title: ALBUM_TITLE)["album_id"]
app.audio.moveToAlbum(album_id: new_album_id, audio_ids: song_ids)
