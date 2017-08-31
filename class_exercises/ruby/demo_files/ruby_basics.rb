=begin
    Demo: Basic Ruby
    Corresponds to: RubyBasics.ppt
=end

# getting started
puts "Say hi"

# topic: dynamic type binding
puts "\nDynamic type binding examples"
list = [2, 4.33, 6, 8]
puts list.class
list = 17.3
puts list.class
puts list

# topic: block structure
puts "\nBlock structure examples"
10.times { puts "hello" }

x = 5
unless x == 10 
    print x
end
# newline
puts 

# topic: numeric
puts "\nNumbers"
puts (7.div 3)
puts (7.fdiv 3)
puts (7.quo 3)
puts (7/3)

# topic: strings
puts "\nString interpolation"
w=5
h=4
puts "The area is #{w*h}"

puts "\nString manipulation"
age = 32
puts "I am " + age.to_s

s = "Hello" 
s << " World"
puts s

puts s[0, 5]

puts "hey " * 5

#topic: no () for function call
"hello".center 20
"hello".delete "lo"

# topic: whitespace in function invocation
def f(x)
    x*x
end

puts f(3+2) + 1
# 5*5+1
puts f (3+2) + 1
# 6*6

s = "cats rule"
puts s[0]
puts s[0,4]
puts s[0..3]
puts s[-4, 4]
puts s.length

