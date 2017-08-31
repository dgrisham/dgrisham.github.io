=begin
    First step in creating the DSL - just respond to the methods
=end
def question(text)
  puts "Just read a question: #{text}"
end

def right(text)
  puts "Just read a correct answer: #{text}"
end

def wrong(text)
  puts "Just read an incorrect answer: #{text}"
end

load 'questions.qm'


