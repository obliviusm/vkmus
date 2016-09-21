#!/usr/bin/env ruby
require 'gracenote'
require 'csv'
require 'pry'

spec = {
  clientID: ENV["CLIENT_ID"],
  clientTag: ENV["CLIENT_TAG"],
  userID: ENV["USER_ID"]
}
obj = Gracenote.new(spec)
CSV.open("csv/grace_songs.csv", "wb") do |csv|
  songs = CSV.read("csv/vk_songs.csv")
  songs.each do |row|
    # row = ["A-ha", "Don't Do Me Any Favours"]
    grace_row = row
    begin
      p row
      # binding.pry
      grace_record = obj.findTrack(row[0], "", row[1], '0')[0]
      grace_hash = {}
      grace_hash[:album_artist_name] = grace_record[:album_artist_name]
      grace_hash[:track_title] = grace_record[:tracks][0][:track_title]
      grace_hash[:album_title] = grace_record[:album_title]
      grace_hash[:album_year] = grace_record[:album_year]
      grace_hash[:genre] = grace_record[:genre].map {|g|  g[:text]}.join("; ")
      grace_hash[:artist_type] = grace_record[:artist_type].map {|at|  at[:text]}.join("; ")
      grace_hash[:mood] = grace_record[:tracks][0][:mood].map {|m|  m[:text]}.join("; ")
      grace_hash[:tempo] = grace_record[:tracks][0][:tempo].map {|t|  t[:text]}.join("; ")
      grace_row = grace_hash.values_at(:album_artist_name, :track_title, :album_title, :album_year, :genre, :artist_type, :mood)
      p 1
    rescue
      # [row[0], row[1]] + [] * 5
    end
    p grace_row
    csv.add_row grace_row
  end
end

# print obj.findTrack("A-ha", "", "Don't Do Me Any Favours", '0').to_yaml

# print obj.findTrack("Whitey", "", "", '0').to_yaml
# p obj.findTrack("Kings Of Convenience", "", "Homesick", '0').inspect
