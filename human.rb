class Human < Player

  def guess(*)
    Question.print(message: "What's your guess #{name}?")
    return gets.chomp.to_i
  end

end
