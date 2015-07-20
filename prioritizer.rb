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
    ask_all_questions
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

  private def ask_all_questions
    number_of_questions.times do |question|
      answer = ask_question(
        question: question,
        message: "What's the name of who should go #{ TURNS[question] }..",
        answer: nil
      )
      set_answer(question, answer)
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
    remaining_entities.each do |entity|
      entity.priority = amount
    end
  end

  private def ask_question(question:, message:, answer: nil)
    return answer unless answer.nil?

    Question.print(message: message){ options }

    ask_question(
      question: question,
      message: "Sorry, we that entity name didn't match. Try again, who should go #{ TURNS[question] }..",
      answer: entity_found_for(gets.chomp)
    )
  end

  private def options
    remaining_entities.each_with_index do |entity, index|
      puts "#{index + 1}: #{entity.name}"
    end
  end

  private def set_answer(question, answer)
    entity = entities.select{ |p| p.name.eql?(answer) }.first
    entity.set_priority(question)

    puts "Decided! #{entity.name} goes #{TURNS[question]}."
  end

  private def entity_found_for(name)
    return name if entities.select{ |e| e.name.eql?(name) }.first
  end

end
