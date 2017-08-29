=begin
	Demo: Module as namespace
	Corresponds to: RubyInheritance.pptx
=end

module Base64

def self.encode (data)
    puts "Encoded data"
end

def self.decode (text)
#could be: Base64.decode
#cannot leave off self
    puts "Decoded data"	
end

end

text = Base64.encode("something")
data = Base64.decode("something")
