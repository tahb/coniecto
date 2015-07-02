require 'pry'

class Result
  attr_reader :guesses, :game

  def initialize(args)
    @guesses = args[:guesses] || []
    @game = args[:game]
  end

  def winners
    @winners ||=
    if determine_winners_by_exact_match.any?
      determine_winners_by_exact_match
    elsif determine_winners_with_margin.any?
      determine_winners_with_margin
    end
    # TODO
    # return determine_winners_by_closest if determine_winners_by_closest.any?
  end

  # Good place to fix. Loops within loops.
  def determine_winners_by_exact_match
    @determine_winners_by_exact_match ||= guesses.inject([]) do |array, guess|
      array << guess.player if guess.number == target
      array
    end
  end

  # TODO
  def determine_winners_with_margin
    guesses.inject([]) do |array, guess|
      array << guess.player if guess.full_range.include?(target)
      array
    end
  end

  # TODO
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

  def print
    puts "The answer was: #{target}"
    if !winners
      feedback = "No winners this time"
    elsif winners.count.eql?(1)
      feedback = "#{winners.first.name} wins!"
    else
      feedback = "The winners are.. #{ winners.collect{|winner| winner.name }.join(', ')}"
    end

    puts feedback
  end

end
