module EasyAccess
    private

    # like `attr_reader
    def self.read(*syms)
        # do nothing if no args
        return if syms.size == 0

        code = ""
        # generate readers
        syms.each { |sym|
            code << "def #{sym}; @#{sym}; end\n"
        }

        # use `class_eval` to create instance methods
        class_eval code
    end

    # like `attr_writer`
    def self.write(*syms)
        # do nothing if no args
        return if syms.size == 0

        code = ""
        # generate writers
        syms.each { |sym|
            code << "def #{sym}=(value); @#{sym} = value; end\n"
        }

        # use `class_eval` to create instance methods
        class_eval code
    end

    # like `attr_accessor`
    def self.readwrite(*syms)
        # generate readers and writers
        syms.each { |sym|
            read(sym)
            write(sym)
        }
    end
end
