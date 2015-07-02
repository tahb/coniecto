class Bot < Player

  def guess
    guess = Random.rand
    puts "Bot #{name} guessed: "
    puts guess
    return guess
  end

end