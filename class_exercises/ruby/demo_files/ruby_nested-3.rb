=begin
Demonstrates the effect of having one method defined within
another. Corresponds to PLConcepts2.
=end
def toggle

    def toggle
        puts "subsequent"
    end

    puts "first"
end

toggle
toggle
toggle
