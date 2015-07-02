class Bot < Player

  def guess
    puts "What's your guess Bot #{name}?"

    guess = Random.rand
    puts guess
    return guess
  end

end