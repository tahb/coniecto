class Game

  attr_accessor :player_set, :limit
  attr_reader :target

  def initialize(args)
    @limit = Integer(args[:limit]) || Random.rand(100)
    @target = Random.rand(@limit)

    @player_set = PlayerSet.new(players: args[:players])
    @player_set.balance
    @player_set.prioritize

  end

  def play
    print_game_info
    results
    print_result
  end

  def print_game_info
    puts "*****************************************************"
    puts "Guess the number. Closest wins."
    puts "*****************************************************"
  end

  def results
    @results ||= Result.new(game: self, guesses: guesses)
  end

  def print_result
    results.print
  end

  private def guesses
    @guesses ||= player_set.guesses(limit)
  end

end
