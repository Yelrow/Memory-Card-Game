require_relative "Card.rb"
require_relative "Board.rb"
require_relative "HumanPlayer.rb"
require_relative "ComputerPlayer.rb"

class Game

  def initialize(player1 = HumanPlayer.new, player2 = ComputerPlayer.new)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
    until @board.won?
      display_score
      match = @current_player.make_guess(@board)
      @current_player += 1 if match
      switch_players unless match
      sleep_and_clear
    end
    determine_winner
    #puts "Congratulations #{@current_player.name} Wins!!"
  end

  def determine_winner
    if @player1.score > @player2.score
      puts "Congratulations #{@player1.name} Wins!!"
    elsif @player1.score == @player2.score
      puts "#{@player1.name} and #{@player2.name} tied."
    else
      puts "Congratulations #{@player2.name} Wins!!"
    end
  end

  def display_score
    puts "#{@player1.name}'s score is #{@player1.score} and #{@player2.name}'s score is #{@player2.score}"
  end

  def sleep_and_clear
    sleep(5)
    system("clear")
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  new_game = Game.new
  new_game.play
end
#
