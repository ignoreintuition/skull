Card = entity:new({
  face = flower,
  x = 8,
  y = 8,
  inHand = true,
  init = function(_ENV)
  end,
  update = function(_ENV, newLoc)
    x = newLoc.x
    y = newLoc.y
  end,
  draw = function(_ENV)
    if not inHand or state.activeDialog then
      circfill(x, y, 12, 7)
      fillp(0x6fc5)
      circfill(x, y, 11, 13)
      fillp(0)
    else
      circfill(x, y, 12, 7)
      circfill(x, y, 11, 13)
      spr(face, x - 8, y - 8, 2, 2)
    end
  end,
  play = function(_ENV, player)
    x = seats[player].x + 16
    y = seats[player].y + 16
    inHand = false
  end
})