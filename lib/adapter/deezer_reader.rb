module Adapter
  class DeezerReader
    def initialize songs:
      @songs = songs
      # @current_song = 0
      @deezer_songs = []
    end

    def perform
      # @deezer_songs = []
      # return false unless @current_song

      @songs.each_with_index do |song, i|
        artist_title = song["artist"] + " " + song["title"]
        puts artist_title
        escape_artist_title = URI.escape artist_title
        response = get_song escape_artist_title
        yield build_song_data(response: response, song: song)
        # if response.code == 200 && i % 10 != 1
        #   @deezer_songs.push save_song(response: response, song: song)
        # else
        #   @current_song = i
        #   p response.message
        #   # sleep 10
        #   return true
        # end
      end

      # @current_song = false
      # return true
    end

    def get_song query
      HTTParty.get("https://api.deezer.com/search/track?q=#{query}")
    rescue Exception => e
      p e
    #   p "retry"
    #   retry
    end

    def build_song_data(response:, song:)
      body = JSON.parse(response.body)

      track = body["data"][0]
      if track
        p "+"
        # track.tap { |track| track["vk_id"] = song["id"] }
        {
          "id" => song["id"],
          "deezer_id" => track["id"],
          "title" => track["title"],
          "artist" => track["artist"]["name"],
        }
      else
        p "-"
        {
          "id" => song["id"],
          "deezer_id" => "",
          "title" => song["title"],
          "artist" => song["artist"]
        }
      end
    end

    # def transform_for_saving deezer_song
    #   {
    #     "id" => deezer_song["vk_id"],
    #     "deezer_id" => deezer_song["id"],
    #     "title" => deezer_song["title"],
    #     "artist" => deezer_song["artist"]["name"],
    #   }
    # end

    # def lines
    #   @deezer_songs.map do |deezer_song|
    #     {
    #       "id" => deezer_song["vk_id"],
    #       "deezer_id" => deezer_song["id"],
    #       "title" => deezer_song["title"],
    #       "artist" => deezer_song["artist"]["name"],
    #     }
    #   end
    # end

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
