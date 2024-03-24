Widget = entity:new({
  bid = 1,
  cancellable = true,
  cb = function()
  end,
  init = function(_ENV, self)
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
    currentBid = bid
    cb()
  end
})