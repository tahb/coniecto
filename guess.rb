class Guess
  attr_reader :player, :number, :error_margin

  def initialize(args)
    @player = args[:player]
    @number = args[:number]
    @error_margin = args[:error_margin]
  end

  def upper
    number + error_margin
  end

  def lower
    number - error_margin
  end

  def full_range
    Range.new(lower, upper)
  end

end
