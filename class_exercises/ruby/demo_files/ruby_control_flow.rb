=begin
    Demo:Control flow
    Corresponds to: Ruby-ControlFlow.ppt
=end

x=5
# topic: return values
puts "Conditionals"
name = if x==1 then "Cyndi"
    else "Nancy"
end
puts "Name: #{name}"

puts "\nCase statement"
income = 20000
tax = case income
    when 0..7550
        income * 0.1
    when 7550..30650
        income * 0.15
    when 3065..50000
        income * 0.25
    else
        income * 0.9
end
puts "Tax: #{tax}"

puts "\nIterator: times"
2.times { puts "OK" }

puts "\nIterator: each"
array = [10, 20]
array.each {|x| puts x }
puts "\nIterator: each range"
(1..4).each {|x| puts x }
puts "\nCan't do range from high to low"
(10..1).each  {|x| puts x }

puts "\nIterator: map"
puts [5,10,15].map { |x| x*x*x }

puts "\nIterator: upto"
factorial = 1
2.upto(20) { |x| factorial *= x}
puts "factorial: #{factorial}"

#topic: yield
puts "\nBasic Yield"
def test   
    puts "You are in the method"   
    yield   
    puts "You are again back to the method"   
    yield
end
test {puts "You are in the block"}


puts "\nYield with parameters"
def test2   
    yield 5   
    puts "You are in the method test"   
    yield 100
end
test2 {|i| puts "You are in the block #{i}"}

