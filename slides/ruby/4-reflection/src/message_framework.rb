class MessageFramework

    def message_hello
        puts "hello"
    end

    def message_in_a_bottle
        puts "Nothing that's worthwhile is ever easy..."
    end

    def show_all_messages
        o = self
        # print names of 'message' methods
        puts "The message method names:"
        o.methods.each do |method|
            if method.to_s[0..6] == "message"
                puts method.to_s
            end
        end
    end

    def run_all_messages
        # run all 'message' methods
        puts "\nThe messages:"
        self.methods.each do |method|
            if method.to_s[0..6] == "message"
                # `send` takes a method (+ args, optionally) and runs it
                self.send method
            end
        end
    end
end

messages = MessageFramework.new
messages.show_all_messages
messages.run_all_messages
