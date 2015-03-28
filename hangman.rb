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
    @checking_player.pick_secret_word
    @guessing_player.recieve_secret_length(@checking_player.secret_length)

    while @checking_player.revealed_word.include?(nil) && strikes > 0
      display
      puts "Strikes Remaining: #{strikes}\n\n"
      letter = @guessing_player.guess
      if @checking_player.check_guess(letter)
        @checking_player.handle_guess_response(letter)
      else
        strikes -= 1
      end
    end

    if @checking_player.revealed_word.include?(nil)
      puts "\n\nSorry You Lost"
    else
      puts "\nYou Win, #{@guessing_player.name}!"
      puts "#{@checking_player.name}'s word was '#{@checking_player.revealed_word.join.upcase}'\n\n"
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
  attr_reader :revealed_word, :secret_length, :name

  def initialize
    puts "What is your name?"
    @name = gets.chomp.capitalize
  end

  def pick_secret_word
    puts "How long is your secret word?"
    @secret_length = gets.chomp.to_i
    @revealed_word = Array.new(@secret_length) {nil}
  end

  def recieve_secret_length(length)

  end

  def guess
    puts "Please choose a letter"
    letter = gets.chomp.downcase
  end

  def check_guess(letter)
    puts "Is '#{letter.upcase}' in your secret word? (y/n)"
    included = gets.chomp.downcase

    if included == "y"
      true
    else
      false
    end
  end

  def handle_guess_response(letter)
    puts "What locations does your word include: '#{letter.upcase}'?"
    puts "Please enter with spaces between each location. (ex. '2 4 6')"
    locations = gets.chomp.split(" ")

    locations.each do |location|
      @revealed_word[location.to_i - 1] = letter
    end

    nil
  end


end



class ComputerPlayer
  attr_reader :revealed_word, :secret_length, :name

  def initialize
    @all_words = File.readlines('dictionary.txt').map(&:chomp)
    @guessed_letters = []
    @name = "Computer"
  end

  def pick_secret_word
    @secret_word = @all_words.sample
    @revealed_word = Array.new(@secret_word.length) {nil}
    @secret_length = @secret_word.length
    @secret_word
  end

  def recieve_secret_length(length)
    @secret_length = length
  end

  def guess
    possible_words = @all_words.select do |word|
      word.length == secret_length
    end
    while true
      guess = possible_words.sample.split("").sample
      if @guessed_letters.include?(guess)
        next
      else
        @guessed_letters << guess
        return guess
      end
    end
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

    nil
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
