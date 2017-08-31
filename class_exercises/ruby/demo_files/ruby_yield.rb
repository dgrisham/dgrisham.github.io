=begin
    Corresponds to Ruby-Methods_Procs.pptx
=end

class NumericSequences
    def fibo(limit)
      i = 1 
      yield 1 
      yield 1 
      a = 1
      b = 1
      while (i < limit)
        t = a
        a = a + b
        b = t
        yield a
        i = i+1
      end
    end 
end

g = NumericSequences::new
g.fibo(10) {|x| print "Fibonacci number: #{x}\n"}
