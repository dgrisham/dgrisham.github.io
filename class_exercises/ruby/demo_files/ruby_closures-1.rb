=begin
http:\\www.skorks.com\2010\05\closuresasimpleexplanationusingruby
=end
class Zombie
    attr_writer :status
    def initialize(state)
        @status = state
    end
    def status_report(state2)
        #note the use of lambda instead of function
        lambda {puts "Zombie1: #{@status}, Zombie2: #{state2}"}
    end
end
def record(closed_case)
    closed_case.call
end
zombie = Zombie.new("undead")
report = zombie.status_report("still undead")
record(report)
zombie.status = "walking"
zombie.status_report("still walking")
record(report)
# will print "Zombie1: undead, Zombie2: still undead"
# shows @status still accessible and state2 still accessible