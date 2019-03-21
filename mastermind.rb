module LOGIC

end

module TEXT
  def intro_text
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

  def guesser_text hash
    valid_input = false
    while !valid_input
      puts "Please enter your guess:"
      input = gets.chomp
      if hash.key? input
        puts "You've already guessed that..."
        next
      end
      if input.to_i.is_a?(Integer) && input.length == 4
        #check the digits are fine.
        split_input = input.split("")
        digits = true
        split_input.each {|x| digits = false unless (x.to_i <= 6 && x.to_i >= 1)}
        split_input.each {|x|
          counter = 0
          split_input.each {|y|
            counter += 1 if x == y
          }
          digits = false if counter > 1
          break if counter > 1
        }

        digits ? (valid_input = true) : puts("Invalid input, please enter 4 numbers between 1 and 6 inclusive.\nEach number is to be used only once.")
      else
        puts("Invalid input, please enter 4 numbers between 1 and 6 inclusive.")
      end
    end
    return input
  end

  def put_result hash
    puts "Your guess has been compared to the code...."
    guess_array = hash.keys
    for x in 0...guess_array.length do
      puts (x+1).to_s << ".   " << guess_array[x].to_s << "  :  " << hash[guess_array[x]].to_s
    end
  end
end

class Game
  include LOGIC
  include TEXT
  @@intro = true

  def initialize
    puts "\n\nYOU ARE NOW PLAYING     ....Mastermind....\n\n"
    intro_text if @@intro
    @code = Code.new
    puts "The code has been set..."
    @guess_hash = {}
    @win = false
    while !@win
      get_guess
      put_result(@guess_hash)
      check_win
    end
    puts "Well done, you won!"
    puts "Would you like to play again? y/n"
    @@intro = false
    again = gets.chomp
    Game.new if again.downcase == "y"
  end

  def get_guess
    guess = guesser_text(@guess_hash)
    @guess_hash[guess] = @code.check_guess(guess)
  end

  def check_win
    @win = (@guess_hash[@guess_hash.keys.last] == "****" ? true : false)
  end
end

class Code
  include LOGIC
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

  def check_guess input
    input_array = input.split("")
    star_count = 0
    plus_count = 0
    input_array.each_with_index {|x, i| 
      @code.each_with_index{|y, j| 
        if x.to_i == y.to_i
          i == j ? star_count += 1 : plus_count += 1
        end
      }
    }
    result = ""
    star_count.times {result << "*"}
    plus_count.times {result << "+"}
    return result
  end
end
Game.new