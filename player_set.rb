require 'faker'

class PlayerSet

  attr_accessor :amount
  attr_reader :players

  # How do we even do words here to handle more players.
  TURNS = {
    0 => "first",
    1 => "second",
    2 => "third",
    3 => "fourth",
    4 => "fifth",
    5 => "sixth",
    6 => "seventh",
    7 => "eighth",
    8 => "ninth"
  }.freeze

  def initialize(args)
    @players = args[:players]
    @amount = players.count
  end

  def balance
    players << add_bot if amount == 1
  end

  def prioritize
    number_of_prio_questions.times do |question_number|
      ask_question(question_number)
      set_answer(question_number)
    end

    prioritize_remainder
  end

  def guesses(limit)
    prioritised_players.inject([]) do |array, player|
      array << Guess.new(player: player, number: player.guess(limit), error_margin: player.error_margin)
      array
    end
  end

  private def amount
    players.count
  end

  private def number_of_prio_questions
    one_v_one? ? 1 : amount - 1
  end

  private def one_v_one?
    amount == 2
  end

  private def group?
    amount > 2
  end

  private def prioritised_players
    @prioritised_players ||= players.sort{ |a,b| a.priority <=> b.priority }
  end

  private def ask_question(question_number)
    print_priority_question(TURNS[question_number])
  end

  private def remaining_players
    players.select{ |p| p.priority.nil? }
  end

  private def print_priority_question(turn="first")
    puts "What's the name of who should go #{turn}.."
    remaining_players.each_with_index do |player, index|
      puts "#{index + 1}: #{player.name}"
    end
    puts ">>"
  end

  private def set_answer(question_number)
    chosen_name = gets.chomp

    player = players.select{ |p| p.name.eql?(chosen_name) }.first
    player.set_priority(question_number)

    puts "Decided! #{player.name} goes #{TURNS[question_number]}."
  end

  private def add_bot
    Bot.new(name: Faker::Name.name, rank: Random.rand(5))
  end

  private def prioritize_remainder
    return if remaining_players.empty?
    remaining_players.each do |player|
      player.priority = amount
    end
  end

end
