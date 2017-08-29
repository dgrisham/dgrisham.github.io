=begin
	Demo: Class variables
	Corresponds to: RubyInheritance.pptx
=end

class Person
	def initialize(name)
		@name = name
		@@what = 12
	end
	def show 
		puts "Person: #{@@something}"
	end
end

class Student < Person

	def make_something
		@@something = 15
	end
	def show 
		puts "Student: #{@@something} and #{@@what}"
	end
	def change_something
		@@something = 25
	end

end

me = Person.new("Cyndi")
you = Student.new("Suzie")
# creates class variable something
you.make_something
you.show
who = Student.new("Joe")
# both Students can access something
who.show
# parent cannot access something
# me.show # error
her = Student.new("Beth")
her.show
her.change_something
her.show
who.show

