Card = entity:new({
  face = flower,
  x = 16,
  y = 16,
  played = false,
  init = function(_ENV)
  end,
  update = function(_ENV)
  end,
  draw = function(_ENV)
    if played then
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
  play = function(_ENV)
  end
})