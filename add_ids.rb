#!/usr/bin/env ruby
require 'gracenote'
require 'csv'
require 'pry'

def find_id(s, songs)
  songs.each do |song|
    # binding.pry
    if song[1] == s[0] && song[2] == s[1]
      return song[0]
    end
  end
  nil
end

def copy_ids songs, grace_songs
  new_songs = []
  grace_songs.each do |s|
    if id = find_id(s, songs)
      new_songs.push s.unshift(id)
    end
  end
  new_songs
end

songs = CSV.read("csv/vk_songs.csv")
grace_songs = CSV.read("csv/grace_songs.csv")
grace_songs_ids = copy_ids songs, grace_songs

CSV.open("csv/grace_songs_ids.csv", "wb") do |csv|
  grace_songs_ids.each do |row|
    csv.add_row row
  end
end
