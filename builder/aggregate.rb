require_relative '../require_all_helper'

NAME = 'marina'
SOURCE_NAME = "#{NAME}/grace"

reader = Adapter::CsvReader.new(SOURCE_NAME)

reader.columns.each do |column_name, column_type|
  aggr_res = Aggregator.aggragate_by reader.get_lines, column_name

  writer = Adapter::CsvWriter.new({
    name: "#{NAME}/aggregate/" + column_name,
    source: reader.filename,
    columns: {column_name => "arr", "count" => "int"},
    description: "Aggragate by #{column_name}"
  })
  writer.write_meta
  writer.write aggr_res
end
