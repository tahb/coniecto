class Prioritizer

  attr_accessor :entities

  # TODO - Find a library or a way to make this problem dissappear.
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

  def initialize(args={})
    @entities = args[:entities]
    return self
  end

  def call
    ask_questions
    automatically_prioritize_remainder

    return prioritised_entities
  end

  private def number_of_questions
    one_v_one? ? 1 : amount - 1
  end

  private def one_v_one?
    amount == 2
  end

  private def group?
    amount > 2
  end

  private def amount
    entities.count
  end

  private def ask_questions
    number_of_questions.times do |question_number|
      ask_question(question_number)
      set_answer(question_number)
    end
  end

  private def prioritised_entities
    entities.sort{ |a,b| a.priority <=> b.priority }
  end

  private def remaining_entities
    entities.select{ |p| p.priority.nil? }
  end

  private def automatically_prioritize_remainder
    return if remaining_entities.empty?
    remaining_entities.each do |player|
      player.priority = amount
    end
  end

  private def ask_question(question_number)
    print_question(TURNS[question_number])
  end

  private def print_question(turn="first")
    puts "What's the name of who should go #{turn}.."
    remaining_entities.each_with_index do |player, index|
      puts "#{index + 1}: #{player.name}"
    end
    puts ">>"
  end

  private def set_answer(question_number)
    chosen_name = gets.chomp

    player = entities.select{ |p| p.name.eql?(chosen_name) }.first
    player.set_priority(question_number)

    puts "Decided! #{player.name} goes #{TURNS[question_number]}."
  end

end
