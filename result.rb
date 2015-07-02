require 'pry'

class Result
  attr_reader :guesses, :game

  def initialize(args)
    @guesses = args[:guesses] || []
    @game = args[:game]
  end

  def winners
    determine_winners_by_exact_match
  end

  # Good place to fix. Loops within loops.
  def determine_winners_by_exact_match
    guesses.inject([]) do |array, guess|
      array << guess.player if guess.number == target
      array
    end
  end

  def determine_winners_by_margin
    guesses.inject([]) do |array, guess|
      array << guess.player if guess.full_range.include?(guess.number)
      array
    end
  end

  def determine_winners_by_closest
    differences = []
    guesses.each do |guess|
      differences << differences_for(guess)
    end
  end

  def differences_for(guess)
    if guess.number > target
      guess.number - target
    elsif guess.number < target
      target - guess.number
    else
      0
    end
  end

  def target
    game.target
  end

end


