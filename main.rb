#!/usr/bin/env ruby
require 'gracenote'

spec = {
  clientID: "883223413",
  clientTag: "810484BCF1F454CF0A456E133A855E02",
  userID: "280164029668204488-CAC04155321454D0490E369346F50E8D"
}
obj = Gracenote.new(spec)
# obj.registerUser # to get userID
p obj.findTrack("Kings Of Convenience", "Riot On An Empty Street", "Homesick", '0').inspect
