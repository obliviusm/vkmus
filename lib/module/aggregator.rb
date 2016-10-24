module Aggregator
  class << self
    def aggragate_by lines, column_name
      lines_counter = Hash.new { 0 }
      lines.each do |line|
        val = line[column_name]
        if val.is_a? Array
          val.each do |v|
            lines_counter[v] += 1
          end
          # val = Coercion.coerce_item_for_csv val, "arr"
        end

        lines_counter[val] += 1
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
