require_relative '../require_all_helper'

NAME = 'misha'
SOURCE_NAME = "#{NAME}/grace"

reader = Adapter::CsvReader.new(SOURCE_NAME)

deezer_reader = Adapter::DeezerReader.new({
  songs: reader.get_lines
})
columns = Adapter::DeezerReader.columns
writer = Adapter::CsvWriter.new({
  name: "#{NAME}/deezer",
  source: reader.filename,
  columns: columns,
  description: "Deezer info about songs",
})

writer.write_meta
writer.write_header

while deezer_reader.perform do
  p deezer_reader.lines
  writer.write_body deezer_reader.lines
end
