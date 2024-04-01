Widget = entity:new({
  bid = 0,
  cancellable = true,
  cb = function()
  end,
  init = function(_ENV, self)
    self.bid = state:get().currentBid + 1
  end,
  update = function(_ENV)
  end,
  draw = function(_ENV)
    rectfill(19, 29, 81, 61, 7)
    rectfill(20, 30, 80, 60, 0)
    print("bid: ⬅️" .. bid .. "➡️", 25, 35, 7)
    if cancellable then
      print("❎ to cancel", 22, 44)
    end
    print("🅾️ to continue", 22, 52)
  end,
  action = function(_ENV)
    local gameScene = state:get()
    gameScene.currentBid = bid
    for v in all(gameScene.players) do
      v.challenger = false
    end
    gameScene.players[gameScene.currentPlayer].challenger = true
    cb()
  end,
  increase = function(_ENV)
    if bid < state:get().maxBid then
      bid += 1
    end
  end,
  decrease = function(_ENV)
    if bid > state:get().currentBid + 1 then
      bid -= 1
    end
  end
})