class Hangman

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

    @checking_player.pick_secret_word
    @guessing_player.guess
    @checking_player.check_guess
    @checking_player.handle_guess_response

  end






end


class HumanPlayer

  def pick_secret_word

  end

  def recieve_secret_length

  end

  def guess

  end

  def check_guess

  end

  def handle_guess_response


  end


end



class ComputerPlayer

  def initialize


  end

  def pick_secret_word

  end

  def recieve_secret_length

  end

  def guess

  end

  def check_guess

  end

  def handle_guess_response


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
