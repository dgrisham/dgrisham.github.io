=begin
    Demo: Method invocation
=end

# topic: method invocation
puts "Method invocation with & w/o parentheses"
puts "Sqrt of 2: #{Math.sqrt(2)}"
puts "Sqrt of 2: #{Math.sqrt 2}"

puts "\nParallel Assignment"
x,y,z = [1,2,3]
puts "x: #{x}"
puts "y: #{y}"
puts "z: #{z}"

puts "\nConstants not really constant!"
MAX = 5
MAX = 6
puts

puts "\nRuby idiom, using short circuit evaluation"
results ||=[]
puts "Results: #{results}"
results2 = [4,5,6]
results2 ||=[]
puts "Results2: #{results2}"

x,y=y,x
puts "x: #{x}"
puts "y: #{y}"

myArray = [1,2,3]
puts "\nMy Array"
puts myArray

puts "\nParallel assignment with unequal number elements"
a,b,c = 1,2
puts "a: #{a}"
puts "b: #{b}"
puts "c: #{c}"

puts "\nSplat"
x, *y = 1,2,3
puts "x: #{x}"
puts "y: #{y}"

puts "\nAnother splat"
*x, y, z = 1,2,3, 4
puts "x: #{x}"
puts "y: #{y}"
puts "z: #{z}"

puts "\nMultiple return values"
def fn
    return 4,5,6
end
x,y,z = fn
puts "x: #{x}"
puts "y: #{y}"
puts "z: #{z}"

puts "\nConditional expressions"
count=0
average = (count == 0)? 0 : sum / count
puts "average #{average}"
count=5
sum=20
average = (count == 0)? 0 : sum / count
puts "average #{average}"

