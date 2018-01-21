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
          @deezer_songs.push track.tap { |track| track["vk_id"] = song["vk_id"] }
        else
          p "-"
        end
      end
    end

    def lines
      @deezer_songs.map do |deezer_song|
        {
          "vk_id" => deezer_song["vk_id"],
          "deezer_id" => deezer_song["id"],
          "title" => deezer_song["title"],
          "artist" => deezer_song["artist"]["name"],
        }
      end
    end
  end
end