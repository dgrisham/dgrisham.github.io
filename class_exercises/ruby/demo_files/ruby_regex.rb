=begin
	Demo: Simple regular expressions
	Corresponds to: Ruby-RegEx.pptx
=end

=begin
Literal characters, case insensitive
=end
puts "Literal Characters"
# nil doesn't print
s = "ruby is cool"
if (s =~ /Ruby/) == nil
  puts "Ruby not found if case sensitive"
end
# let's do case insensitive, order of pattern/string doesn't matter
location = s =~ /Ruby/i
puts "Found Ruby/i at #{location}"
location = /Ruby/i =~ s 
puts "Found Ruby/i at #{location}"
# can also use as part of a condition
if s =~ /Ruby/i
	puts "found Ruby - case insensitive"
end
=begin
Character class
=end
puts "\nCharacter class"
s2 = "i love ruby!"
location = s2  =~ /[Rr]uby/
puts "Found [Rr]uby at #{location}"
s3 = "welcome to Ruby!"
location = s3  =~ /[Rr]uby/
puts "Found [Rr]uby at #{location}"
location = s2 =~ /[aeiou]/ 
puts "First vowel found at #{location}"
location = s3 =~ /[aeiou]/ 
puts "First vowel found at #{location}"
=begin
Anchor (begin or end of string)
=end
puts "\nAnchors"
if s =~ /\Aruby/
	puts "found Ruby at beginning"
end
if s2 =~ /\Aruby/
  puts "found Ruby at beginning"
else
  puts "ruby is not at the beginning"
end
if s2 =~ /ruby!\z/
  puts "found ruby! at end"
end
s4 = "are you a rubyist?"
if s2 =~ /\bRuby\b/i 
  puts "Found ruby as a word"
end 
if s4 =~ /\bRuby\b/i 
  puts "Found ruby as a word"
else
  puts "ruby not an individual word"
end
if s4 =~ /ruby/i 
  puts "but it is a part of a word"
end
=begin
Alternatives
=end
puts "\nAlternatives"
s3 = "I love Java and Ruby and PHP"
if s3 =~ /Java|PHP/
	puts "what, another language?"
end
if s2 =~ /Java|PHP/
  puts "what, another language?"
else
  puts "nope, only ruby"
end
=begin
Special character classes 
=end
puts "\nSpecial character classes"
# Regular character class, easy to recognize/remember
partNum = "aZ2"
if partNum =~ /[a-z][A-Z][0-9]/
	puts "part number is lower-case then upper-case then digit"
end
# Same pattern with special character class
if partNum =~ /[a-z][A-Z]\d/
	puts "part number is still lower-case then upper-case then digit"
end
if partNum =~ /[A-Za-z0-9][A-Za-z0-9][A-Za-z0-9]/
	puts "part number has 3 word characters"
end
if partNum =~ /\w\w\w/
	puts "part number still has 3 word characters"
end
if partNum =~ /..\d/
	puts "part number is two characters followed by a digit"
end
if partNum =~ /\D\D\d/
	puts "part number is two non-digits followed by a digit"
end
partNum = "123"
if partNum =~ /\D\D\d/
  puts "part number is two non-digits followed by a digit"
else 
  puts "part number is invalid"
end
if partNum =~ /..\d/
	puts "part number is two characters followed by a digit"
end
partNum = "3.A"
# escape special characters
if partNum =~ /\d\.A/
  puts "part number is digit, period, A"
end
=begin
Repetition
=end
puts "\nRepetition"
anotherPart = "A45@"
if anotherPart =~ /.[0-9]+@/
	puts "another part is any character, one or more digits, @"
end
anotherPart = "A@"
if anotherPart =~ /.[0-9]+@/
  puts "OK"
else
  puts "another part must contain one or more digits"
end
if anotherPart =~ /.[0-9]*@/
	puts "another part is any character, optional digits, @"
end
if anotherPart =~ /.[0-9]?@/
	puts "another part is any character, optional one digit, @"
end
anotherPart = "A1@"
if anotherPart =~ /A[0-9]?@/
	puts "another part is A, optional one digit, @"
end
anotherPart = "A12@"
if anotherPart =~ /A[0-9]?@/
  puts "another part is A, optional one digit, @"
else 
  puts "another part cannot have 2 digits"
end
=begin
Non-greedy repetition
=end
puts "\nGreedy vs Non-greedy"
quoted = '"abc" and "def"'
quoted =~ /".*"/
# not covered yet, but shows what was matched
puts $~
quoted =~ /".*?"/
puts $~


