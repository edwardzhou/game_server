class DDZPlayer
  #@pokes = []
  #@pokes_flag = []
  #@user = nil

  attr_accessor :pokes, :pokes_flag, :user, :last_player, :next_player, :card

  def initialize
    @pokes = []
    @pokes_flag = []
    @user = nil
  end

end