#!/usr/bin/env ruby
require 'gracenote'
require 'csv'
require 'pry'

def get_max_singers songs
  max_singers = Hash.new { 0 }
  songs.each do |s|
    max_singers[s[1]] += 1
  end
  max_singers.sort_by { |k, v| v }.reverse
end

songs = CSV.read("csv/vk_songs.csv")
max_singers = get_max_singers songs

CSV.open("csv/max_singers.csv", "wb") do |csv|
  max_singers.each do |row|
    csv.add_row row
  end
end
