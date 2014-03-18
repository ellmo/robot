# coding: utf-8

class Robot
  attr_accessor :x, :y, :f, :board

  ROTATIONS = [[1,0], [0,1], [-1,0], [0,-1]]

  def initialize x, y, f=nil
    raise ArgumentError.new unless x.between?(0, 4) && y.between?(0,4)
    teleport x, y, f
  end

  def rotate dir=1
    @f = ROTATIONS[(ROTATIONS.index(@f) + dir) % 4]
  end

  def teleport x, y, f=nil
    return false unless x.between?(0, 4) && y.between?(0,4)
    if f.nil?
      @f ||= [1,0]
    else
      @f = translate_facing(f) ? ROTATIONS[translate_facing(f)] : [1,0]
    end
    @x, @y = x, y
  end

  def move
    return false unless (@y + @f[0]).between?(0, 4) && (@x + @f[1]).between?(0,4)
    @y += @f[0]
    @x += @f[1]
  end

  def translate_facing f
    case f
    when /n/i then 0
    when /e/i then 1
    when /s/i then 2
    when /w/i then 3
    else nil
    end
  end

  def facing
    case ROTATIONS.index(@f)
    when 0 then 'north'
    when 1 then 'east'
    when 2 then 'south'
    else 'west'
    end
  end

  def char
    case ROTATIONS.index(@f)
    when 0 then '△'
    when 1 then '▷'
    when 2 then '▽'
    else '◁'
    end
  end

  def report
    "The robot is at X: #{@x} Y:#{@y} and is facing #{facing}."
  end
end