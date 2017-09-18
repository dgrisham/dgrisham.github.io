=begin
    Demo: Module as namespace
=end

module Base64

def self.encode(data)
    puts "Encoded data"
end

# could be: Base64.decode, but that breaks when module name changes
def self.decode(text)
    puts "Decoded data" 
end

end

text = Base64.encode("something")
data = Base64.decode("something")
