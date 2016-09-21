#!/usr/bin/env ruby
require 'gracenote'
require 'csv'
require 'pry'

grace_songs = CSV.read("csv/grace_songs_ids.csv")

# binding.pry
grace_songs = grace_songs.keep_if { |s| s.compact.size > 3 }

CSV.open("csv/only_grace.csv", "wb") do |csv|
  grace_songs.each do |row|
    csv.add_row row
  end
end
