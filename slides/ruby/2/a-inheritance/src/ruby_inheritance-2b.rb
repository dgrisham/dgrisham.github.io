=begin
    Demo: Method visibility
=end

class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end

  def talk_to(friend)
    puts "Talking to #{@friend}"
  end
  private :talk_to
end

p = Person.new("Yeezy")
# error: hidden method
p.talk_to("Weezy")
