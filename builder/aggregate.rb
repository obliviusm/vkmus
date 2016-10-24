require_relative '../require_all_helper'

NAME = 'music'
SOURCE_NAME = "output/grace/#{NAME}"

reader = Adapter::CsvReader.new(SOURCE_NAME)

reader.columns.each do |column_name, column_type|
  aggr_res = Aggregator.aggragate_by reader.get_lines, column_name

  writer = Adapter::CsvWriter.new({
    name: "aggregate/" + column_name,
    source: reader.filename,
    columns: {column_name => "arr", "count" => "int"},
    description: "Aggragate by #{column_name}"
  })
  writer.write_meta
  writer.write aggr_res
end
