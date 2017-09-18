require_relative 'pikachu'

pika = Pikachu.new("", 0)
pika.instance_variables.each { |var|
    print "Input a value for Pikachu's #{var[1..var.length]}: "
    value = gets.chomp
    pika.instance_variable_set(var, value)
}
puts pika
