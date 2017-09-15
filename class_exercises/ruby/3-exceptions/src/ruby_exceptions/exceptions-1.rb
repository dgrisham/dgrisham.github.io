=begin
	Demo: Exception handling
	Code taken from The Ruby Programming Language
=end

def factorial(n)
	# common to "raise" a string
	raise "bad argument" if n < 1
	return 1 if n == 1
	n * factorial(n-1)
end

def factorial2(n)
	# can raise a defined exception
	raise ArgumentError if n < 1
	return 1 if n == 1
	n * factorial(n-1)
end

def factorial3(n)
	# raise can include a message
	raise ArgumentError, "Expected argument >= 1, got #{n}" if n < 1
	return 1 if n == 1
	n * factorial(n-1)
end

def factorial4(n)
	if n < 1
		# can include a call stack
		raise ArgumentError, "Expected argument >= 1, got #{n}", caller 
	end
	return 1 if n == 1
	n * factorial(n-1)
end

def callFac4
  factorial4(0)
end

# uncomment to see various errors 
#factorial(0)
#factorial2(0)
#factorial3(0)
#factorial4(0)
#callFac4

=begin
	x = factorial(0)
rescue => ex
	puts "#{ex.class}: #{ex.message}"
=end

=begin
	x = factorial(0)
rescue => ex
	puts "#{$!.class}: #{$!.message}"
=end

def factorial5(n)
	raise TypeError, "Integer argument expected" if not n.is_a? Integer
	raise ArgumentError, "Expected argument >= 1, got #{n}" if n < 1
	return 1 if n == 1
	n * factorial(n-1)
end

=begin
	x = factorial5("a")
# can rescue multiple types of errors, order does matter
rescue ArgumentError => ex
	puts "Try again with argument > 1"
rescue TypeError => ex
	puts "Try again with an integer"
=end
