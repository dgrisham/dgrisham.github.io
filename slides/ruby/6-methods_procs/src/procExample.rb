def powers(max, proc1, proc2)
  (1..max).each { |i|
    puts "#{i} #{proc1.call(i)} #{proc2.call(i)}"
  }
end

power2 = Proc.new { |x| x ** 2 }
power3 = Proc.new { |x| x ** 3 }
power4 = Proc.new { |x| x ** 4 }

puts "Calculating powers -- square and cube"
powers(5, power2, power3)
puts

puts "Calculating powers -- square and fourth power"
powers(5, power2, power4)
