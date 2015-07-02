require 'pry'

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
        Person.new(name: "Tom", rank: 1),
        Person.new(name: "Mark", rank: 2),
        Person.new(name: "BoB", rank: 3),
      ],
      limit: 125
    ).play
  end
end

