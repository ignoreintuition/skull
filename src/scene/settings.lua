Settings = Scene:new({
  playerCnt = 6,
  init = function(_ENV, self)
    playerCnt = self.playerCnt
  end,
  update = function(_ENV)
    playerCnt = state.playerCnt
    return 'settings'
  end,
  draw = function(_ENV)
    cls()
    rectfill(0, 0, 127, 127, 6)
    rect(2, 2, 125, 125, 0)
    rectfill(4, 4, 123, 123, 0)
    spr(7, 45, 20, 4, 2)
    spr(37, 15, 39, 1, 1)
    print("players: " .. playerCnt, 25, 40, 7)
  end

})