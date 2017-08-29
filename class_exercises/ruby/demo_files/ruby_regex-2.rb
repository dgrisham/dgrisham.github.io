# Match Data
"I love petting cats and dogs" =~ /cats/
puts "full string: #{$~.string}"
puts "match: #{$~.to_s}"
puts "pre: #{$~.pre_match}"
puts "post: #{$~.post_match}"

# Named Captures
str = "Ruby 1.9"
if /(?<lang>\w+) (?<ver>\d+\.(\d+)+)/ =~ str
  puts lang
  puts ver
end
str = "Java 8.1"
if /(?<lang>\w+) (?<ver>\d+\.(\d+)+)/ =~ str
  puts lang
  puts ver
end

# Regexp class
ruby_pattern = Regexp.new("ruby", Regexp::IGNORECASE)
puts ruby_pattern.match("I love Ruby!")
puts ruby_pattern =~ "I love Ruby!"

lang_pattern = Regexp.union("Ruby", "Perl", /Java(Script)?/)
puts lang_pattern.match("I know JavaScript")

pattern = Regexp.union("()","[]","{}")