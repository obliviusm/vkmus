module Adapter
  class DeezerReader
    def initialize songs:
      @songs = songs
      @deezer_songs = []
    end

    def perform
      @songs.each_with_index do |song, i|
        artist_title = song["artist"] + " " + song["title"]
        puts i, artist_title
        response = HTTParty.get("https://api.deezer.com/search/track?q=#{artist_title}")
        body = JSON.parse(response.body)

        track = body["data"][0]
        if track
          p "+"
          @deezer_songs.push track.tap { |track| track["vk_id"] = song["id"] }
        else
          p "-"
          @deezer_songs.push ({
            "vk_id" => song["id"],
            "id" => "",
            "title" => song["title"],
            "artist" => {
              "name" => song["artist"]
            }
          })
        end
      end
    end

    def lines
      @deezer_songs.map do |deezer_song|
        {
          "id" => deezer_song["vk_id"],
          "deezer_id" => deezer_song["id"],
          "title" => deezer_song["title"],
          "artist" => deezer_song["artist"]["name"],
        }
      end
    end

    def self.columns
      {
        "id" => "int",
        "deezer_id" => "int",
        "title" => "str",
        "artist" => "str",
      }
    end
  end
end
