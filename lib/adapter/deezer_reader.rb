module Adapter
  class DeezerReader
    def initialize songs:
      @songs = songs
      @current_song = 0
    end

    def perform
      @deezer_songs = []
      return false unless @current_song

      @songs[@current_song..-1].each_with_index do |song, i|
        artist_title = song["artist"] + " " + song["title"]
        puts i, artist_title
        response = HTTParty.get("https://api.deezer.com/search/track?q=#{artist_title}")
        if response.code == 200
          save_song(response: response, song: song)
        else
          @current_song = i
          p response.message
          return true
        end
      end

      @current_song = false
      return true
    end

    def save_song(response:, song:)
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
