# coding: utf-8

class Robot
  attr_accessor :x, :y, :f, :board

  ROTATIONS = [[1,0], [0,1], [-1,0], [0,-1]]

  def initialize x, y, f=nil
    teleport x, y
    @f = [1,0]
  end

  def rotate dir=1
    @f = ROTATIONS[(ROTATIONS.index(@f) + dir) % 4]
  end

  def teleport x, y
    @x = x
    @y = y
  end

  def move
    @y += @f[0]
    @x += @f[1]
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