class Winners

  attr_reader :type, :guesses

  def initialize(args)
    @type = args[:type]
    @guesses = args[:guesses]
  end

  def print
    case type
    when :by_match then puts "The winner by direct match is: "
    when :by_margin then puts "The winner by match is: "
    when :by_closest then puts "The winner by closest is: "
    else end

    guesses.each{ |guess| puts guess.player.name }
    return nil
  end

end
