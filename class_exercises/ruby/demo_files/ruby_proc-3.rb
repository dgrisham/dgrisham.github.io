=begin
=end

class ToDo 
  def buyGroceries
    puts "Buy Groceries"
  end
  
  def doHomework
    puts "Do Homework"
  end

end

todo = ToDo.new
todo.instance_eval("buyGroceries")

