require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/original/#{NAME}"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines

grace = Adapter::GracenoteReader.new()
grace_songs = grace.get_songs(songs)

writer = Adapter::CsvWriter.new({
  name: "grace/" + NAME,
  source: reader.filename,
  columns: grace.columns,
  description: "Get gracenote info for vk music"
})
writer.write_meta
writer.write grace_songs
