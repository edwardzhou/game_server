module PokeType
  DAN_PAI = 1
  DUI_PAI = 2
  SAN_ZHANG = 3
  SAN_DAI_YI = 4
  DAN_SHUN = 5
  SHUANG_SHUN = 6
  SAN_SHUN = 7
  FEI_JI = 8
  SI_DAI_ER = 9
  ZHA_DAN = 10
  HUO_JIAN = 11
  ERROR = 12

  DIR_H = 0
  DIR_V = 1
end

class Poke

  # 16小王，17大王
  def self.get_poke_value(poke)
    case poke
      # 当扑克值为52时，是小王
      when 52
        return 16
      # 当扑克值为53时，是大王
      when 53
        return 17
      # 其它情况下返回相应的值(3,4,5,6,7,8,9,10,11(J),12(Q),13(K),14(A),15(2))
      else
        return poke / 4 + 3
    end
  end

  def self.get_poke_count(pokes, poke)
    pokes.select { |p| p == poke }.size
  end

  def self.get_poke_type(pokes)
    len = pokes.size
    result = PokeType::ERROR


    # 当牌数量为1时,单牌
    if len == 1
      result = PokeType::DAN_PAI

    # 当牌数量为2时,可能是对牌和火箭
    elsif len == 2
      if pokes[0] == 53 and pokes[1] == 52
        result = PokeType::HUO_JIAN
      elsif get_poke_value(pokes[0]) == get_poke_value(pokes[1])
        result = PokeType::DUI_PAI
      end

    #	当牌数为3时,只可能是三顺
    elsif len == 3
      result = PokeType::SAN_ZHANG if get_poke_value(pokes[0]) == get_poke_value(pokes[1]) and
          get_poke_value(pokes[1]) == get_poke_value(pokes[2])

    # 当牌数为4时,可能是三带一或炸弹
    elsif len == 4
      first_count = get_poke_count(pokes, pokes[0])
      if first_count == 4
        result = PokeType::ZHA_DAN
      elsif first_count == 3 or get_poke_count(pokes, pokes[1]) == 3
        result = PokeType::SAN_DAI_YI
      end

    # 当牌数大于5时,判断是不是单顺
    elsif len == 5
      result = is_shun_zhi(pokes)

    # 当牌数为6时,四带二
    elsif len == 6
      have4 = pokes.select{|poke| get_poke_count(pokes, poke) == 4}.size > 0
      have1 = pokes.select{|poke| get_poke_count(pokes, poke) == 1}.size > 0

      result = PokeType::SI_DAI_ER if have4 and have1
    end

    # 当牌数大于等于6时,先检测是不是双顺和三顺
    if len >= 6
      # 双顺
      shuang_shun_flag = pokes.select{ |poke| get_poke_count(pokes, poke) != 2 }.size == 0

      return PokeType::SHUANG_SHUN if shuang_shun_flag and is_shun_zhi(pokes.uniq)

      san_shun_flag = pokes.select{ |poke| get_poke_count(pokes, poke) != 3 }.size == 0
      return PokeType::SAN_SHUN if san_shun_flag and is_shun_zhi(pokes.uniq)
    end

    if (len >= 8) and (len % 4 == 0)

    end

  end

  def self.get_poke_type_value(pokes, poke_type)

  end

  def self.is_shun_zhi(pokes)
    start = get_poke_value(pokes[0])
    return false if start >=15

    poke_values = pokes.collect{|poke| get_poke_value(poke)}

    v = poke_values.shift
    poke_values.each do |pv|
      return false if pv - v != 1
      v = pv
    end

    true
  end

end