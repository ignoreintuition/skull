UI = entity:new({
  init = function(_ENV)
  end,
  update = function(_ENV)
  end,
  draw = function(_ENV)
    cls()
    drawHeader(_ENV)
    drawCanvas(_ENV)
    drawRightRail(_ENV)
    drawFooter(_ENV)
  end,
  drawHeader = function(_ENV)
    rectfill(0, 0, 127, 7, 2)
    line(0, 7, 127, 7, 7)
    print('skull', 0, 0, 7)
    print('round ' .. gameScene.round, 96, 0, 7)
  end,
  drawCanvas = function(_ENV)
    rectfill(0, 8, 95, 94, 0)
  end,
  drawRightRail = function(_ENV)
    rectfill(96, 8, 127, 127, 2)
    rectfill(98, 10, 125, 125, 125, 15)
  end,
  drawFooter = function(_ENV)
    rectfill(0, 95, 95, 127, 2)
  end
})