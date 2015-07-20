class PlayerSet

  attr_accessor :players

  def initialize(args)
    @players = args[:players]
  end

  def guesses(limit)
    players.inject([]) do |array, player|
      array << Guess.new(player: player, number: player.guess(limit), error_margin: player.error_margin)
      array
    end
  end

end
