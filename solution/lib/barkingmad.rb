require 'ffaker'

class Human
  attr_reader :first_name, :last_name, :title, :formal_name, :country
  def initialize(opts={})
    @first_name  = opts[:first_name]
    @last_name   = opts[:last_name]
    @title       = opts[:title]
    @country     = opts[:country]
    @formal_name = "#{title} #{last_name}"
  end

  def greet(other_human=nil)
    if other_human
      return "Hi #{other_human.first_name}, my name is #{formal_name}"
    end

    "Hi, my name is #{formal_name}"
  end

end

class BarkingMad
  def self.potato
    "potato!"
  end

  def self.random_new_human
    Human.new(
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      title: FFaker::Name.prefix,
      country: FFaker::Address.country
    )
  end
end

if __FILE__ == $PROGRAM_NAME
  p BarkingMad.potato
  p "Random name: #{ FFaker::Name.name }"
  p "Random email: #{ FFaker::Internet.email }"
end
