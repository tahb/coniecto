class Bot < Player

  def guess(limit)
    guess = Random.rand(limit)
    puts "Bot #{name} guessed: "
    puts guess
    return guess
  end

end