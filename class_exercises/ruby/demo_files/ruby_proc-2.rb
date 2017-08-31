=begin
    Demo: Using Proc and eval
    Corresponds to: RubyMetaprogramming.pptx
=end


require 'singleton'
class TryIt 
    include Singleton
    
    def show_what n
        puts n
    end
end

# eval considered evil by many
# eval is executed in the current context, need to specify class
eval "TryIt.instance.show_what 6"
# instance_eval in context of the object/class
TryIt.instance_eval("TryIt.instance.show_what 22")
TryIt.instance.instance_eval("show_what 16")
cmd = "show_what "
print "Enter a number: "
num = gets.chomp
cmd << num
puts cmd
TryIt.instance.instance_eval(cmd)

# class does not need to be a singleton
class TryAgain
    
    def show_what n
        puts n
    end
end

tryAgain = TryAgain.new
tryAgain.instance_eval("show_what 12")


