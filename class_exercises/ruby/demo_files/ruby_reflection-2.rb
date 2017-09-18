=begin
    Demo: Simple reflection
=end

class Message_framework 
    def message_hello
        puts "hello"
    end
    
    def message_goodbye
        puts "goodbye"
    end
    
    def show_all_messages
        o = self
        # first list the methods, just to show what we've found
        puts "The message names"
        o.methods.each do |method|
            if (method.to_s[0..6] == "message")
                puts method.to_s
            end
        end
    end
    
    def run_all_messages
        # now execute the methods
        puts "\nThe messages"
        self.methods.each do |method|
            if (method.to_s[0..6] == "message")
                self.send method
            end
        end
    end
end

messages = Message_framework.new
messages.show_all_messages
messages.run_all_messages