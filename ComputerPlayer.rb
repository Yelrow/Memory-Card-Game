require_relative "Card.rb"
require_relative "Board.rb"

class ComputerPlayer
  attr_reader :name, :score
  def initialize(name="iComputer")
    @name = name
    @score = 0
  end

  def +(num)
    @score += num
    self
  end

  def populate_hash(board)
    @not_guessed = []
    @already_guessed = Hash.new {|h,k| h[k] = []}
    board.length.times do |i|
      board.length.times do |j|
        pos = [i,j]
        card = board[pos]
        if card.guessed && !(card.visible)
          @already_guessed[card.face_value] << pos
        elsif !card.guessed
          @not_guessed << pos
        end
      end
    end
  end

  def make_guess(board)
    populate_hash(board)
    guess1, guess2 = match
    card1 = board[guess1]
    card1.reveal
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

  def match
    good_guesses = @already_guessed.select {|k,v| v.length > 1}
    if good_guesses.length > 0
      return good_guesses.values[0]
    end
    @not_guessed = @not_guessed.shuffle
    guess1 = @not_guessed.pop
    guess2 = @not_guessed.pop
    #both guess1 and guess2 are empty
    if !guess1 && !guess2
      return @already_guessed.values[-2..-1]
    elsif guess1 && !guess2
      return @already_guessed.values[-1] + [guess1]
    end
    [guess1,guess2]
  end

end
