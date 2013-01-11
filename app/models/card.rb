class Card
  attr_accessor :value, :poke_type, :pokes, :player

  def initialize(pokes, player)
    self.pokes = pokes
    self.player = player
    self.poke_type = Poke.get_poke_type(pokes)
    self.value = Poke.get_poke_type_value(pokes, self.poke_type)
  end
end