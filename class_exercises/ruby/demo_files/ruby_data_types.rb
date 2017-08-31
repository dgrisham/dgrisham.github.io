=begin
    Ruby Arrays, Hashes, etc.
    Corresponds to RubyDataTypes.ppt
=end

# topic: Arrays
puts "\nArray Basics"
a = [1,2,3]
puts a
puts "Length: #{a.length}"
a2 = [-10..0, 0..10]
puts "Length of [-10..0, 0..10] = #{a2.length}"
puts "The first element: #{a2[0]}"
a3 = [[1,2],[3,4]]
w=5
h=5
a4 = [w*h, w, h]
a5 = []
puts "An empty list: #{a5} ..."

puts
words = %w[here we go again]
puts words

a6 = [1,3,5]
a6 << 7
a6 << 9
puts a6

puts
alphabet = ('A'..'J').to_a
puts alphabet
alphabet.each {|c| print c }
puts

# topic: Hashes
puts "\nHashes"
colors = { :Cyndi => "orange", :Karyl => "purple" }
colors2 = { "Cyndi" => "orange", "Karyl" => "purple" }
colors3 = { Cyndi: "orange", Karyl: "purple" }
puts "Cyndi's favorite color: #{colors3[:Cyndi]}"
puts "Everyones favorite colors:"
colors.each do |key, value|
    puts "#{key}'s favorite color is #{value}"
end

# topic: Ranges
puts "\nRanges"
coldwar = 1945..1989
birthyear = 1950
puts coldwar.include? birthyear
puts (1..3).to_a 
