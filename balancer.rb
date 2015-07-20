require 'faker'

class Balancer

  attr_accessor :entities

  def initialize(args={})
    @entities = args[:entities]
    return self
  end

  def call
    entities << generate_bot unless balanced?
    return entities
  end

  private def balanced?
    (amount % 2).zero?
  end

  private def amount
    entities.count
  end

  private def generate_bot
    Bot.new(name: Faker::Name.name, rank: Random.rand(5))
  end

end
