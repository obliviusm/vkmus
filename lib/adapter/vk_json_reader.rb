module Adapter
  class VkJsonReader
    attr_reader :filename
    def initialize name
      @filename = "input/#{name}.json"
    end

    def column_names
      columns.keys
    end

    def column_types
      columns.values
    end

    def columns
      {
        "id" => "int",
        "artist" => "str",
        "title" => "str",
        "duration" => "int",
        "date" => "int",
        "url" => "str",
        "lyrics_id" => "int",
        "genre_id" => "int"
      }
    end

    def get_songs
      file = File.read @filename
      songs = JSON.parse(file)["response"]["items"]
      songs.delete_at(0)
      songs = songs.map do |song|
        song.map {|k, v| [k, HTMLEntities.new.decode(v)] }.to_h
      end
      # binding.pry
      songs = Coercion.coerce songs, columns
    end
  end
end
