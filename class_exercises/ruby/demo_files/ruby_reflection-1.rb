=begin
    Demo: Reflection Methods
=end

class Cat
    def initialize(name, age)
        @name = name
        @age = age
    end
    
    def purr
        puts "purrrrrr"
    end
    
    def show_local
        x = 5
        local_variables.each do |var|
            puts var
        end
    end
    
    def show_methods
        Cat.instance_methods(false).each do |method|
            puts method.to_s
        end
    end
    
end

cat = Cat.new("Fluffy", 6)
puts cat.class
puts "Cat? #{cat.is_a? Cat}"
puts "String? #{cat.is_a? String}"
puts "Object? #{cat.is_a? Object}"
puts "Kind of cat? #{cat.kind_of? Cat}"
puts "Kind of object? #{cat.kind_of? Object}"
puts "Instance variables"
cat.instance_variables.each do |var|
    puts var
end
puts "Local variables"
cat.show_local
puts "Methods"
cat.show_methods
# after a few more slides, talks about creating an instance
someObj = cat.class.new("Bobo",5)
puts "Cat? #{someObj.is_a? Cat}"




