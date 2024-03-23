Dialog = entity:new({
  cb = function() end,
  text = "",
  cancellable = true,
  init = function(_ENV, self)
  end,
  update = function(_ENV)
  end,
  draw = function(_ENV)
    rectfill(19, 19, 81, 81, 7)
    rectfill(20, 20, 80, 80, 0)
    print(text, 35, 24, 7)
    if cancellable then
      print("❎ to cancel", 22, 64)
    end
    print("🅾️ to continue", 22, 72)
  end
})