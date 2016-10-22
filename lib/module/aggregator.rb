module Aggregator
  class << self
    def aggragate_by lines, column_name
      lines_counter = Hash.new { 0 }
      lines.each do |line|
        lines_counter[line[column_name]] += 1
      end
      lines_counter = lines_counter.map do |k, v|
        {column_name => k, "count" => v }
      end
      sort_lines lines_counter, "count"
    end

    def sort_lines lines, column_name
      lines.sort_by { |line| line[column_name] }.reverse
    end
  end
end
