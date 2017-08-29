outer = "?"
def question punc
	inner = "Is this a question"
	puts "Variable inner: #{inner}"
	proc {inner + punc}
end
p = question(outer) # Variable inner: Is this a question
puts "Result after the proc call: #{p.call}" # Result after the proc call: Is this a question?
outer = "."
puts "Change punctuation of outer: #{outer}" # Change punctuation of outer: .
puts "Result after the proc call: #{p.call}" # Result after the proc call: Is this a question?