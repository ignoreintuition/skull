GameOver = Scene:new({
  winner = 0,
  delay = 60,
  init = function(_ENV)
    timer = 0
  end,
  update = function(_ENV)
    if timer > delay then
    if btnp(🅾️) then 
      return 'title'
    end
    else
      timer += 1
    end
    return 'gameOver'
  end,
  draw = function(_ENV)
    cls()
    print('game over', 40, 40, 7)
    print('winner is player ' .. state.winner, 24, 56, 7)
    if timer > delay then
      print('press 🅾️ to restart', 22, 64, 7)
    end
  end
})