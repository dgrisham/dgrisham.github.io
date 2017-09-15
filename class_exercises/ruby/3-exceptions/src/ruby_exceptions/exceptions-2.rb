# This code shows how errors are propagated
def explode 
	raise "bam!" if rand(10) == 0
end

def risky
	begin
		10.times do
    		#raises error ~10% of time
			explode
		end
	rescue TypeError # won't catch RuntimeError
		puts $! 
	end
	"hello" # if no exception
end

def defuse
	begin
		puts risky
	rescue RuntimeError => e
		puts e.message
	end
end

defuse
