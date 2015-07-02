require 'faker'

class PlayerSet

  attr_accessor :amount
  attr_reader :players

  TURNS = {
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth"
  }

  def initialize(args)
    group(args[:players])
    @amount = @players.count
  end

  def amount
    players.count
  end

  def balance
    players << add_bot if amount == 1
  end

  def prioritize
    number_of_questions.times do |i|
      i += 1
      ask_question(i)
      set_answer(i)
    end
  end

  def ask_question(i)
    print_priority_question(TURNS[i])
  end

  def number_of_questions
    if amount == 2
      return 1
    elsif amount > 2
      return amount - 1
    end
  end

  def guesses
    players.inject([]) do |array, player|
      array << Guess.new(player: player, number: player.guess, error_margin: player.error_margin)
      array
    end
  end

  private def print_priority_question(turn="first")
    puts "What's the name of who should go #{turn}.."
    players.each_with_index do |player, index|
      next if player.priority
      puts "#{index+1}: #{player.name}"
    end
    puts ">>"
  end

  private def set_answer(i)
    chosen_name = gets.chomp

    player = players.select{ |p| p.name.eql?(chosen_name) }.first
    player.set_priority(i)

    puts "Decided! #{player.name} goes #{TURNS[i]}."
  end

  private def add_bot
    Bot.new(name: Faker::Name.name, rank: Random.rand(5))
  end

  private def group(players)
    @players = players.inject([]) do |array, player|
      array << player
      array
    end
  end

end
