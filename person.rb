class Person < Player

  def guess
    puts "What's your guess #{name}?"
    return gets.chomp.to_i
  end

end
