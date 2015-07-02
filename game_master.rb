class GameMaster

  attr_accessor = :game

  def self.setup(args)
    @game = Game.new(args)
  end

  def play
    game.play
  end

  def self.example
    Game.new(
      players: [
        Human.new(name: "Tom", rank: 1),
        Human.new(name: "Mark", rank: 2),
        Bot.new(name: "BoB", rank: 3),
      ],
      limit: 125
    ).play
  end
end

