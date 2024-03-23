Player = entity:new({
  active = false,
  colors = {},
  hand = {},
  stack = {},
  losses = 0,
  name = 'player1',
  number = 1,
  wins = 0,
  currentBid = 0,
  init = function(_ENV, self)
    self.colors = colorRamps[self.number]
    self.hand = Hand:new()
    self.stack = Stack:new()
  end,
  update = function(_ENV)
    hand:update()
  end,
  draw = function(_ENV)
    pal(13, colors[1])
    pal(6, colors[2])
    drawPlayer(_ENV)
    drawHand(_ENV)
    drawStack(_ENV)
    drawStats(_ENV)
    pal()
  end,
  drawHand = function(_ENV)
    if active then
      hand:draw()
    end
  end,
  drawStack = function(_ENV)
    stack:draw()
  end,
  drawPlayer = function(_ENV)
    spr(5, seats[number].x, seats[number].y, 2, 2)
    spr(5, seats[number].x + 16, seats[number].y, 2, 2, true)
    spr(5, seats[number].x, seats[number].y + 16, 2, 2, false, true)
    spr(5, seats[number].x + 16, seats[number].y + 16, 2, 2, true, true)
  end,
  drawStats = function(_ENV)
    print(name, 100, 12 + 16 * (number - 1) + (number - 1) * 2, 13)
    print(currentBid .. "/" ..wins .. "/" .. losses, 100, 12 + 16 * (number - 1) + (number - 1) * 2 + 8, 7)
  end
})