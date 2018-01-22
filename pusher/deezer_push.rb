require_relative '../require_all_helper'

NAME = 'misha'
SOURCE_NAME = "#{NAME}/deezer"

reader = Adapter::CsvReader.new(SOURCE_NAME)
songs = reader.get_lines.keep_if { |song| song["deezer_id"].present? }

