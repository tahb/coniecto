require 'pry'

class Game
  attr_accessor :player_set, :limit
  attr_reader :target

  def initialize(args)
    @limit = args[:limit] || Random.rand(100)
    @target = Random.rand(@limit)
    @difficulty = args[:difficulty] || Random.rand(5)

    print_game_info

    @player_set = PlayerSet.new(players: args[:players])
    @player_set.balance
    @player_set.prioritize
  end

  def play
    result = Result.new(game: self, guesses: player_set.guesses)
    result.print
  end

  def print_game_info
    puts "*****************************************************"
    puts "Guess the number. Closest wins."
    puts "*****************************************************"
  end

end
