class Hangman
  STRIKES = 10

  def initialize(guessing_player, checking_player)
    if guessing_player == 'y'
      @guessing_player = HumanPlayer.new
    else
      @guessing_player = ComputerPlayer.new
    end

    if checking_player == 'y'
      @checking_player = HumanPlayer.new
    else
      @checking_player = ComputerPlayer.new
    end

  end

  def play
    puts "Lets Play!"
    strikes = STRIKES
    secret_word = @checking_player.pick_secret_word.split("")
    display
    puts "Strikes Remaining: #{strikes}\n\n"
    while @checking_player.revealed_word.include?(nil) && strikes > 0
      letter = @guessing_player.guess
      if @checking_player.check_guess(letter)
        @checking_player.handle_guess_response(letter)
      else
        strikes -= 1
      end
      display
      puts "Strikes Remaining: #{strikes}\n\n"
    end

    if @checking_player.revealed_word.include?(nil)
      puts "Sorry You Lost"
    else
      "You Win!"
    end

  end

  def display
    displayed_word = ""
    @checking_player.revealed_word.each do |letter|
      if letter == nil
        displayed_word << "_"
      else
        displayed_word << letter
      end
    end

    puts "Current word is: #{displayed_word}"
  end

end


class HumanPlayer

  def pick_secret_word

  end

  def recieve_secret_length

  end

  def guess
    puts "Please choose a letter"
    letter = gets.chomp.downcase
  end

  def check_guess

  end

  def handle_guess_response


  end


end



class ComputerPlayer
  attr_reader :revealed_word

  def initialize
    @possible_words = File.readlines('dictionary.txt').map(&:chomp)
  end

  def pick_secret_word
    @secret_word = @possible_words.sample
    @revealed_word = Array.new(@secret_word.length) {nil}
    @secret_word
  end

  def recieve_secret_length

  end

  def guess

  end

  def check_guess(letter)
    if @secret_word.include?(letter)
      puts "Yes, my word includes '#{letter}'"
      return true
    else
      puts "No, my word does not include '#{letter}'"
      return false
    end
  end


  def handle_guess_response(guess)
    @secret_word.each_char.with_index do |letter, idx|
      @revealed_word[idx] = letter if guess == letter
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  puts "Is the guessing player a Human? (y/n)"
  guessing = gets.chomp.downcase
  puts "Is the checking player a Human? (y/n)"
  checking = gets.chomp.downcase

  game = Hangman.new(guessing,checking)
  game.play

end
