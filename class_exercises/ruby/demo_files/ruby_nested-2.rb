=begin
Demonstrates that Ruby methods are not truly nested (inner can't
access variables of outer). Corresponds to PLConcepts3.
=end
def test_outer( a, b )
   def test_inner( a )
		puts "#{a} and #{b}"
   end
	puts "#{a} and #{b}"
	test_inner( a+b )
end

test_outer( 1, 2 )
