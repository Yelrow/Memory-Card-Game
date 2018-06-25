require_relative "Card.rb"
require_relative "Board.rb"

class HumanPlayer
  attr_reader :name, :score
  def initialize(name="Christopher")
    @name = name
    @score = 0
  end

  def +(num)
    @score += num
    self
  end

  def prompt
    puts "Enter Position([X,Y])"
    input = gets.chomp.split(",").map(&:to_i)
  end

  def valid_guess(board)
    valid = false
    until valid
      input = prompt
      #input needs to be within bounds
      if input[0] < 4 && input[1] < 4
        card = board[input]
        #card cant be visible
        unless card.visible
          valid = true
        else
          puts "Invalid: Try again Input is already visible."
        end
      else
        puts "Invalid: Try again Input is out of bounds."
      end

    end
    input
  end

  def make_guess(board)
      board.render
      guess1 = valid_guess(board)
      card1 = board[guess1]
      card1.reveal
      board.render
      puts "Make your second guess"
      guess2 = valid_guess(board)
      card2 = board[guess2]
      card2.reveal
      board.render

      if card1 == card2
        puts "#{@name} chose a correct match!"
        return true
      else
        puts "#{@name} chose an incorrect match!"
        card1.hide
        card2.hide
        return false
      end
    end
end
