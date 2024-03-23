Title = Scene:new({
  init = function(_ENV)
  end,
  update = function(_ENV)
    return 'title'
  end,
  draw = function(_ENV)
    cls()
    rectfill(0, 0, 127, 127, 6)
    rect(2, 2, 125, 125, 0)
    rectfill(4, 4, 123, 123, 0)
    spr(7, 45, 20, 4, 2)
    print("a game by ignoreintuition", 15, 40, 7)
    print("adapted from the game by", 15, 48, 7)
    print("herve marly", 40, 56, 7)
    print("press 🅾️ to start", 30, 72, 7)
    

  end
})