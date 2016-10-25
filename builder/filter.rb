require_relative '../require_all_helper'

NAME = 'sydorov'
SOURCE_NAME = "#{NAME}/grace"
AGGR_PATH = "#{NAME}/aggregate/"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines

# column_name = 'genre'
columns = ['artist', 'album_title', 'genre', 'mood', 'tempo']
columns.each do |column_name|
  p column_name
  aggr_reader = Adapter::CsvReader.new(AGGR_PATH + column_name)
  all_values = aggr_reader.get_lines.map { |line| line[column_name] }.delete_if(&:empty?)
  all_values.each do |column_value|
    # p songs.count
    sub_songs = Filterer.by songs, column_name, column_value
    next if sub_songs.size < 4

    writer = Adapter::CsvWriter.new({
      name: "#{NAME}/filter/#{column_name}/#{Common.to_filename column_value}",
      source: reader.filename,
      columns: reader.columns,
      description: "Filter #{column_name} by {column_value}"
    })
    writer.write_meta
    writer.write Marshal.load( Marshal.dump(sub_songs) )
  end
end
