=begin
    Corresponds to Ruby-Methods_Procs.pptx
=end
# generate sequence of n numbers m*i + c
def sequence(n,m,c)
  i=0
  while (i < n)
    yield i*m + c
    i += 1
  end
end

puts "Sequence of n=5 numbers m=2*i + c=4"
sequence(5, 2, 4) { |x| puts x }
sum = 0;
sequence(5,2,5) { |x| sum = sum + x }
puts "Sum: #{sum}"
puts "\nFiltering numbers < 10"
sequence(5,2,5) { |x| if (x < 10) then puts x end }

def sequence3(n,m,c, &b)
  i=0
  while (i < n)
    b.call(i*m + c)
    #yield i*m + c This still works
    i += 1
  end
end

puts "\nSame sequence passing a block as an argument"
sequence3(5, 2, 4) { |x| puts x }

def sequence4(n,m,c, b)
  i=0
  while (i < n)
    b.call(i*m + c)
    i += 1
  end
end
puts "\nSame sequence using a Proc"
p = Proc.new { |x| puts x }
sequence4(5, 2, 4, p) 

def mysequence(n,m,b)
  i = n
  while (i < m)
    puts b.call(i)
    i = i+1
  end
end

puts "\nmysequence - just another example"
p2 = Proc.new { |x| x * x }
mysequence(2,5,p2)

puts "\nExecute two different methods of Proc"
f = Proc.new { |x, y| x + y}
puts f.call(4,5)
puts f.arity
