module Adapter
  class GracenoteReader
    def initialize
      credentials = {
        clientID: ENV["CLIENT_ID"],
        clientTag: ENV["CLIENT_TAG"],
        userID: ENV["USER_ID"]
      }
      @grace = Gracenote.new(credentials)
    end

    def columns
      {
        "id" => "int",
        "artist" =>  "str",
        "title" => "str",
        "album_title" => "str",
        "artist_type" => "arr",
        "album_year" => "int",
        "genre" => "arr",
        "mood" => "arr",
        "tempo" => "arr"
      }
    end

    def get_songs songs
      songs.map {|song| get_song song }.compact
    end

    def get_song song
      print song.to_yaml
      record = @grace.findTrack(song["artist"], "", song["title"], '0')[0]
      grace_song = {
        "id" => song["id"],
        "artist" =>  record[:album_artist_name],
        "title" => record[:tracks][0][:track_title],
        "album_title" => record[:album_title],
        "artist_type" => extract_text(record[:artist_type]),
        "album_year" => record[:album_year],
        "genre" => extract_text(record[:genre]),
        "mood" => extract_text(record[:tracks][0][:mood]),
        "tempo" => extract_text(record[:tracks][0][:tempo])
      }
      print grace_song.to_yaml
      grace_song
    rescue
      nil
      # {
      #   "id" => "",
      #   "artist" =>  "",
      #   "title" => "",
      #   "album_title" => "",
      #   "artist_type" => [],
      #   "album_year" => "",
      #   "genre" => [],
      #   "mood" => [],
      #   "tempo" => []
      # }
    end

    def extract_text arr
      # binding.pry
      if arr.is_a? Array
        arr.map {|g|  g[:text]}
      else
        p arr
        []
      end
    end
  end
end
