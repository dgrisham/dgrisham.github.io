class Pikachu
    attr_accessor :name, :level

    def initialize(name, level)
        @name = name
        @level = level
    end

    def to_s
        puts "#{@name} is a level #{@level} Pikachu"
    end
end
