require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/original/#{NAME}"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines

p songs[0]
