module Adapter
  class CsvReader
    attr_reader :filename

    def initialize filename
      @filename = filename + ".csv"
      @filename_meta  = filename + "_meta.csv"
    end

    def get_lines
      lines = CSV.read(@filename)
      lines.delete_at(0)
      lines_to_hash lines
    end

    def lines_to_hash lines
      lines = lines.map do |line|
        Hash[ meta_hash["column_names"].zip(line) ]
      end
      Coercion.coerce lines, meta_hash["columns"]
    end

    def meta_hash
      return @meta_hash if @meta_hash

      meta = CSV.read(@filename_meta)
      @meta_hash = meta_to_hash meta
      # binding.pry
      @meta_hash["columns"] = Hash[ @meta_hash["column_names"].zip(@meta_hash["column_types"]) ]
      @meta_hash
    end

    def meta_to_hash meta
      meta_hash = {}
      meta.each do |row|
        val = row.size == 2 ? row[1] : row[1..-1]
        meta_hash[row[0]] = val
      end
      meta_hash
    end
  end
end
