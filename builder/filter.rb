require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/grace/#{NAME}"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines

column_name = 'genre'
column_value = 'Electronica'
sub_songs = Filterer.by songs, column_name, column_value

writer = Adapter::CsvWriter.new({
  name: "filter/#{column_name}/#{column_value.downcase.underscore}",
  source: reader.filename,
  columns: reader.columns,
  description: "Filter #{column_name} by {column_value}"
})
writer.write_meta
writer.write sub_songs
