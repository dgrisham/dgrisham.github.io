=begin
    Demo: Method arguments
=end

=begin
    Illustrate default arguments
=end
def title(name, len=3)
  name[0,len]
end

# what does this say about the order of evaluation?
def punctuation(sentence, index=sentence.size-1)
  sentence[index, sentence.size-index]
end

puts title("Ms. Jolene Juniper")
puts title("Dr. Cyndi Rader")
puts title("Mrs. Anne Smith", 4)
puts punctuation("OMG!!!", 3)
puts punctuation("How do you feel today?")

=begin
    Illustrate variable # of arguments
=end
def limitedSum(max, *rest)
  sum = 0
  rest.each {|num| sum += num }
  if sum > max
    max
  else
    sum
  end
end
puts "\nLimited sum examples"
puts limitedSum(20, 1,4,5)
puts limitedSum(20, 10, 20, 30)
puts limitedSum(20)
data = [1,4,5]
# try this without the *
# splat (*) has split mode and collect mode
# in this line, it splits the array into multiple args
# in the parameter list, it collects multiple args into array
puts limitedSum(20, *data)

=begin
    Illustrate hashes as arguments
=end

def greeting(args)
  greet = args[:greet] || "Hi"
  title = args[:title] || "Citizen"
  name = args[:name]  
  puts "#{greet} #{title} #{name}"
end
puts "\nGreeting examples"
greeting(:greet=>"Hello", :title=>"Sir", :name=>"McCarthy")
greeting(:title=>"Sir", :name=>"McCarthy", :greet=>"Howdy")

