=begin
Demonstrates the effect of having one method defined within
another. Corresponds to PLConcepts2.
=end
class Largeco
  class Person
    def hello
      # notice definition of hi inside hello
      def hi
        "hello"  
      end
      def bye
        "goodbye"
      end
      hi
    end
 
    def hi
      "hi"
    end
 
    def bye
      "bye-bye"
    end
  end
end
puts "Scott and Mark are casual"
scott = Largeco::Person.new
mark = Largeco::Person.new
puts "Scott says: #{scott.hi}"
puts "Mark says: #{mark.hi}"
puts "Scott says: #{scott.bye}"
puts "Mark says: #{mark.bye}"
puts "\nBUT Chris is formal, everyone must respond in kind"
chris = Largeco::Person.new
puts "Chris says: #{chris.hello}"
puts "Scott says: #{scott.hi}"
puts "Chris says: #{chris.bye}"
puts "Scott says: #{scott.bye}"