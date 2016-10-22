require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/grace/#{NAME}"

reader = Adapter::CsvReader.new(SOURCE_NAME)
# songs = reader.get_lines

column_name = "artist"
column_type = "str"
aggr_res = Aggregator.aggragate_by reader.get_lines, column_name

writer = Adapter::CsvWriter.new({
  name: "aggregate/#{NAME}_" + column_name,
  source: reader.filename,
  columns: {column_name => column_type, "count" => "int"},
  description: "Aggragate by #{column_name}"
})
writer.write_meta
writer.write aggr_res
