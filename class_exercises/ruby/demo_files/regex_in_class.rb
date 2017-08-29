# unit tests for float, complex, date

def is_float(the_string)
  if (the_string =~ /[0-9]*\.[0-9]+/)
    puts "is float"
  else
    puts "not float"
  end
end
def is_float_charclass(the_string)
  if (the_string =~ /\d*\.\d+/)
    puts "is float"
  else
    puts "not float"
  end
end

is_float "1.2"
is_float_charclass "1.2"

def is_date(the_string)
  if (the_string =~ /[1-12]-[1-31]-/)
    puts "is date"
  else
    puts "not date"
  end  
end

is_date "1-15-"
s4 = "1234"
if (s4 =~ /\d{4}/)
  puts "yes"
else
  puts "no"
end







