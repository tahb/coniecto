class Result
  attr_reader :guesses, :game
  attr_accessor :by_matching, :by_marginal, :by_closest

  WINNING_ORDER = [ :by_matching, :by_marginal, :by_closest ].freeze

  def initialize(args)
    @guesses = args[:guesses] || []
    @game = args[:game]

    @by_matching = []
    @by_marginal = []
    @by_closest = []

    calculate_winners
  end

  def winners
    WINNING_ORDER.each do |type|
      return Winners.new(type: type, guesses: self.send(type)) unless self.send(type).empty?
    end
  end

  private def calculate_winners
    guesses.each do |guess|
      set_matching(guess)
      set_marginal(guess)
      set_closest(guess)
    end
  end

  private def closer_guess?(guess)
    return true if by_closest.nil?
    (target - guess.number) < (target - by_closest.number)
  end

  private def set_matching(guess)
    by_matching << guess if guess.number == target
  end

  private def set_marginal(guess)
    by_marginal << guess if guess.full_range.include?(target)
  end

  # Ew.
  private def set_closest(guess)

    if by_closest.empty? or by_closest.nil?
      set_closet(guess)
    else
      new_difference = difference_to_target(guess.number)
      previous_difference = difference_to_target(by_closest.first.number)

      set_closet(guess) if new_difference < previous_difference
      add_closest(guess) if new_difference == previous_difference
    end
  end

  private def set_closet(guess)
    @by_closest = [ guess ]
  end

  private def add_closest(guess)
    by_closest << guess
  end

  private def target
    game.target
  end

  private def difference_to_target(number)
    if number > target
      number - target
    else
      target - number
    end
  end

end
