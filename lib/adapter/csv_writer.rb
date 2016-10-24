module Adapter
  class CsvWriter
    def initialize params
      @filename = "output/#{params[:name]}.csv"
      @filename_meta = "output/#{params[:name]}_meta.csv"
      @source = params[:source]
      @columns = params[:columns]
      @description = params[:description]

      make_dir_if_needed @filename
    end

    def make_dir_if_needed filepath
      dirname = filepath.split("/").tap{ |p| p.pop }.join("/")
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def write_meta
      CSV.open(@filename_meta, "wb") do |csv|
        csv.add_row ["description", @description]
        csv.add_row ["source", @source]
        csv.add_row ["column_names", *@columns.keys]
        csv.add_row ["column_types", *@columns.values]
      end
    end

    def write lines
      lines = Coercion.coerce_for_csv lines, @columns
      CSV.open(@filename, "wb") do |csv|
        csv.add_row @columns.keys
        lines.each do |line|
          # p line.values_at(*@columns.keys)
          csv.add_row line.values_at(*@columns.keys)
        end
      end
    end
  end
end
