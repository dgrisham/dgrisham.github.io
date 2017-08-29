require_relative "RubyOpenClasses-1.rb"

class Cat
	def purr
		puts "#{@name} says Purrrrrrrrrrr"
	end
end

ollie = Cat.new("Ollie", 5)
ollie.purr
