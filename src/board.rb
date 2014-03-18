# coding: utf-8

class Board
  HEIGHT = 5
  WIDTH = 5

  attr_accessor :robot

  def initialize
    @robot = nil
  end

  def draw row
    if @robot and @robot.y == row
      WIDTH.times.map do |x|
        @robot.x == x ? "[x]" : "[ ]"
      end.join
    else
      "[ ]" * WIDTH
    end
  end
end