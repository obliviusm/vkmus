require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/grace/#{NAME}"
AGGR_NAME = "output/aggregate/"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines

column_name = 'genre'
reader = Adapter::CsvReader.new(AGGR_NAME + column_name)
all_values = reader.get_lines.map { |line| line[column_name] }.compact
# column_value = 'Electronica'
all_values.each do |column_value|
  sub_songs = Filterer.by songs, column_name, column_value

  writer = Adapter::CsvWriter.new({
    name: "filter/#{column_name}/#{Common.to_filename column_value}",
    source: reader.filename,
    columns: reader.columns,
    description: "Filter #{column_name} by {column_value}"
  })
  writer.write_meta
  writer.write sub_songs
end
