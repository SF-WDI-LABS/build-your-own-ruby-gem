require 'ffaker'

class BarkingMad
  def self.potato
    "potato!"
  end
end

if __FILE__ == $PROGRAM_NAME
  p BarkingMad.potato
  p "Random name: #{ FFaker::Name.name }"
  p "Random email: #{ FFaker::Internet.email }"
end
