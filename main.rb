#!/usr/bin/env ruby
require 'gracenote'

spec = {
  clientID: ENV["CLIENT_ID"],
  clientTag: ENV["CLIENT_TAG"],
  userID: ENV["USER_ID"]
}
obj = Gracenote.new(spec)
# obj.registerUser # to get userID
p "---------------------------------"
p "---------------------------------"
p "---------------------------------"
p "---------------------------------"
p "---------------------------------"
p "---------------------------------"

print obj.findTrack("Kings Of Convenience", "", "Homesick", '0').to_yaml

# print obj.findTrack("Whitey", "", "", '0').to_yaml
# p obj.findTrack("Kings Of Convenience", "", "Homesick", '0').inspect
