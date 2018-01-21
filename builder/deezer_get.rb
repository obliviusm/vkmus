require_relative '../require_all_helper'

NAME = 'misha'
SOURCE_NAME = "#{NAME}/grace"

reader = Adapter::CsvReader.new(SOURCE_NAME)

deezer_reader = Adapter::DeezerReader.new({
  songs: reader.get_lines[0..3]
})

deezer_reader.perform
p deezer_reader.lines
# writer = Adapter::CsvWriter.new({
#   name: "#{NAME}/deezer",
#   source: reader.filename,
#   columns: deezer_reader.columns,
#   description: "Aggragate by #{column_name}"
# })

# writer.write_meta
# writer.write deezer_reader.lines
