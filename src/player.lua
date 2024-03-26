Player = entity:new({
  active = false,
  colors = {},
  hand = {},
  stack = {},
  losses = 0,
  number = 1,
  wins = 0,
  face = 38,
  currentBid = 0,
  passed = false,
  challenger = false,
  init = function(_ENV, self)
    self.colors = colorRamps[self.number]
    self.hand = Hand:new()
    self.stack = Stack:new({ playerNumber = self.number })
    self.face = rnd(8) + 38
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
    spr(face, 98, 11 + 16 * (number - 1) + (number - 1) * 2)
    print("p" .. number, 108, 12 + 16 * (number - 1) + (number - 1) * 2, 13)
    if challenger then
      circfill(120, 11 + 16 * (number - 1) + (number - 1) * 2 + 4, 3, 11)
      print(state:get().currentBid, 119, 12 + 16 * (number - 1) + (number - 1) * 2 + 1, 7)
    end
    if passed then
      circfill(120, 11 + 16 * (number - 1) + (number - 1) * 2 + 4, 3, 8)
      print("x", 119, 12 + 16 * (number - 1) + (number - 1) * 2 + 1, 7)
    end
    print("w" .. wins .. " l" .. losses, 100, 12 + 16 * (number - 1) + (number - 1) * 2 + 8, 7)
  end
})