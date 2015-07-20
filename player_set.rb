require 'faker'

class PlayerSet

  attr_accessor :players

  def initialize(args)
    @players = args[:players]
    @amount = players.count
  end

  def balance
    players << add_bot if amount == 1
  end

  end

  def guesses(limit)
    players.inject([]) do |array, player|
      array << Guess.new(player: player, number: player.guess(limit), error_margin: player.error_margin)
      array
    end
  end

  private def add_bot
    Bot.new(name: Faker::Name.name, rank: Random.rand(5))
  end
end
