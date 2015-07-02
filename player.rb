class Player
  attr_reader :name, :rank
  attr_accessor :priority

  MODIFIER = 10.freeze

  def initialize(args)
    @name = args[:name]
    @rank = args[:rank]
    @priority = args[:priority]
  end

  def set_priority(integer)
    @priority = integer
  end

  def name
    @name.downcase
  end

  def error_margin
    rank * MODIFIER
  end

end
