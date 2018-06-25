class Card
  attr_reader :face_value, :visible, :guessed
  def initialize(face_value=nil)
    @face_value = face_value
    @visible = false
    @guessed = false
  end

  def hide
    @visible = false
  end

  def reveal
    @guessed = true
    @visible = true
  end

  def to_s
    if @visible
      @face_value.to_s
    else
      "_"
    end

  end

  def ==(card)
    return true if @face_value == card.face_value
    false
  end
end
