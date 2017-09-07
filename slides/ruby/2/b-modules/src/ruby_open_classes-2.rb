require_relative "ruby_open_classes-1.rb"

class Pikachu
  def attack
    puts "#{name} used thundershock!"
  end
end

sparky = Pikachu.new("Sparky", 5)
sparky.attack
