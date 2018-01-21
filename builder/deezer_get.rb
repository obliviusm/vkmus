require_relative '../require_all_helper'

NAME = 'misha'
SOURCE_NAME = "#{NAME}/grace"

reader = Adapter::CsvReader.new(SOURCE_NAME)

deezer_reader = Adapter::DeezerReader.new({
  songs: reader.get_lines[0..3]
})
columns = Adapter::DeezerReader.columns

deezer_reader.perform
p deezer_reader.lines
writer = Adapter::CsvWriter.new({
  name: "#{NAME}/deezer",
  source: reader.filename,
  columns: columns,
  description: "Deezer info about songs",
  write_mode: "update"
})

writer.write_meta
writer.write deezer_reader.lines
