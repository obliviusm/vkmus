require_relative '../require_all_helper'

def album_create_or_get app, album_title
  album_hashes = app.audio.getAlbums()["items"]
  album = album_hashes.keep_if { |a| a["title"] == album_title }[0]
  if album
    album["id"]
  else
    app.audio.addAlbum(title: album_title)["album_id"]
  end
end

NAME = "misha"
SOURCE_NAME = "#{NAME}/filter/genre/trance"
ALBUM_TITLE = "Trance"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines
song_ids = songs.map{ |s| s["id"] }.join(",")
# p song_ids

app = VK::Application.new(version: '5.53', access_token: ENV['VK_ACCESS_TOKEN'])
album_id = album_create_or_get app, ALBUM_TITLE
app.audio.moveToAlbum(album_id: album_id, audio_ids: song_ids)
