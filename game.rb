class Game
  
  attr_accessor :player_set, :limit
  attr_reader :target

  def initialize(args)
    @limit = args[:limit] || Random.rand(100)
    @target = Random.rand(@limit)
    @difficulty = args[:difficulty] || Random.rand(5)

    @player_set = PlayerSet.new(players: args[:players])
    @player_set.balance
    @player_set.prioritize
    
    print_game_info
  end

  def play
    result.print
  end
  
  def result
    @result ||= Result.new(game: self, guesses: player_set.guesses)  
  end
  
  def print_game_info
    puts "*****************************************************"
    puts "Guess the number. Closest wins."
    puts "*****************************************************"
  end

end
