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
      by_match << guess if guess.number == target
      by_margin << guess if guess.full_range.include?(target)
      set_closest(guess)
    end
  end

  private def closer_guess?(guess)
    return true if by_closest.nil?
    (target - guess.number) < (target - by_closest.number)
  end

  # Ew.
  private def set_closest(guess)

    if by_closest.empty? or by_closest.nil?
      @by_closest = [ guess ]
    else
      new_diff = target - guess.number
      old_diff = target - by_closest.first.number

      @by_closest << guess if new_diff == old_diff
      @by_closest = [ guess ] if new_diff < old_diff
    end

  end

  private def target
    game.target
  end

end
