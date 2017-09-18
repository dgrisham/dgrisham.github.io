require_relative "easy_access.rb"

class Pikachu
    include EasyAccess

    EasyAccess.read(:level)
    EasyAccess.readwrite(:name)

    def initialize(name, level)
        @name = name
        @level = level
    end
end

p = Pikachu.new("Sparky", 5)
puts p.name
p.name = "Pika"
puts p.name
puts p.level
