module LOGIC

end

module TEXT
  def intro_text
    puts "YOU ARE NOW PLAYING     ....Mastermind....\n\n"
    puts "You will need to crack a code of 4 numbers, using digits 1-6 inclusive. \nEach digit will only appear once."
    puts "You will make guesses in order to crack the code."
    puts "After each guess, you will be told information about that guess"
    puts "For each correct guess in the correct place, you will be given a star (*)."
    puts "For each correct guess in the wrong place you will be given a plus (+).\n\n"
    puts "For an example type 'ex', otherwise type 'play' to begin."
    valid_input = false
    counter = 0
    while !valid_input
      input = gets.chomp.downcase
      counter += 1
      if input == "ex"
        puts "For example, if the code was 1234 and your guess was 3246,"
        puts "the output would be *++, to indicate that one of your numbers was in the correct place,"
        puts "and that two of your numbers were correct but in the wrong place."
        valid_input = true
      elsif input == "play"
        valid_input = true
      else
        if counter < 3
          puts "Invalid input, please enter either 'ex' or 'play'"
        else
          puts "For example, if the code was 1234 and your guess was 3246,"
          puts "the output would be *++, to indicate that one of your numbers was in the correct place,"
          puts "and that two of your numbers were correct but in the wrong place."
          valid_input = true
        end
      end
    end
  end
end

class Game
  include LOGIC
  include TEXT
  def initialize
    intro_text
    @code = Code.new
  end

  def get_guess

  end
end

class Code
  attr_reader :code
  def initialize
    @code = []
    initiate = 0
    while initiate < 4
      code_variable = rand(1..6)
      unless @code.include? code_variable
        initiate += 1
        @code.push(code_variable)
      end
    end
  end

  def check_code input
    
  end
end
Game.new