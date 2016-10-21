#!/usr/bin/env ruby
require 'gracenote'
require 'csv'
require 'pry'

def join_to_field arr
  # binding.pry
  if arr.is_a? Array
    arr.map {|g|  g[:text]}.join("/")
  else
    arr
  end
end

spec = {
  clientID: ENV["CLIENT_ID"],
  clientTag: ENV["CLIENT_TAG"],
  userID: ENV["USER_ID"]
}
obj = Gracenote.new(spec)
CSV.open("csv/grace_json3.csv", "wb") do |csv|
  headers = [:vk_id, :album_artist_name, :track_title, :album_title, :album_year, :genre, :artist_type, :mood].map(&:to_s)
  csv.add_row headers

  songs = CSV.read("csv/vk_json.csv")
  songs.delete_at(0)
  # songs = songs[507..-1]
  songs.each do |row|
    # row = ["A-ha", "Don't Do Me Any Favours"]
    grace_row = row[1..2]
    # begin
      p row
      # binding.pry
      grace_record = obj.findTrack(row[1].to_s, "", row[2].to_s, '0')[0]
      grace_hash = {}
      grace_hash[:vk_id] = row[0]
      grace_hash[:album_artist_name] = grace_record[:album_artist_name]
      grace_hash[:track_title] = grace_record[:tracks][0][:track_title]
      grace_hash[:album_title] = grace_record[:album_title]
      grace_hash[:album_year] = grace_record[:album_year]
      grace_hash[:genre] = join_to_field grace_record[:genre]
      grace_hash[:artist_type] = join_to_field grace_record[:artist_type]
      grace_hash[:mood] = join_to_field grace_record[:tracks][0][:mood]
      grace_hash[:tempo] = join_to_field grace_record[:tracks][0][:tempo]
      grace_row = grace_hash.values_at(:vk_id, :album_artist_name, :track_title, :album_title, :album_year, :genre, :artist_type, :mood)
      p 1
    # rescue
    #   # [row[0], row[1]] + [] * 5
    # end
    p grace_row
    csv.add_row grace_row
  end
end

# print obj.findTrack("A-ha", "", "Don't Do Me Any Favours", '0').to_yaml

# print obj.findTrack("Whitey", "", "", '0').to_yaml
# p obj.findTrack("Kings Of Convenience", "", "Homesick", '0').inspect
