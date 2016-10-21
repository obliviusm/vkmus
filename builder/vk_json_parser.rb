require_relative '../require_all_helper'

NAME = 'music'

reader = Adapter::VkJsonReader.new(NAME)
songs = reader.get_songs
writer = Adapter::CsvWriter.new({
  name: NAME,
  source: reader.filename,
  columns: reader.columns,
  description: "Parsed json file with vk music data"
})
writer.write_meta
writer.write songs
