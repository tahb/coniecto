class Game

  attr_accessor :player_set, :limit
  attr_reader :target

  def initialize(args)
    @limit = Integer(args[:limit]) || Random.rand(100)
    @target = Random.rand(@limit)

    @player_set = PlayerSet.new(players: args[:players])
    @player_set.players = Balancer.new(entities: @player_set.players).call
    @player_set.players = Prioritizer.new(entities: @player_set.players).call
  end

  def play
    print_game_info
    winners = result.winners
    print_game_target
    winners.print
  end

  private def print_game_info
    puts "*****************************************************"
    puts "Guess the number. Closest wins."
    puts "*****************************************************"
  end

  private def print_game_target
    puts "*****************************************************"
    puts "The number you had to guess was #{target}!"
    puts "*****************************************************"
  end

  private def result
    @result ||= Result.new(game: self, guesses: guesses)
  end

  private def guesses
    @guesses ||= player_set.guesses(limit)
  end

end
