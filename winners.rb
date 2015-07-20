require 'active_support/inflector'

class Winners

  attr_reader :type, :guesses

  def initialize(args)
    @type = args[:type]
    @guesses = args[:guesses]
  end

  def print
    case type
    when :by_matching then puts "The winner by direct match: "
    when :by_marginal then puts "The #{ "winner".pluralize } by marginal match: "
    when :by_closest then puts "The #{ "winner".pluralize } by closest: "
    else end

    guesses.each{ |guess| puts guess.player.name }
    return nil
  end

end
