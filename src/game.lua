state = 'game'
prevState = 'game'

function _init()
  gameScene = GameScene:new()
  printMeta()
end

function _update()
  if prevState != state then
    if state == 'game' then
      gameScene:init()
    end
    prevState = state
  end
  if state == 'game' then
    state = gameScene:update()
  end
end

function _draw()
  if state == 'game' then
    gameScene:draw()
  end
end

function printMeta()
  printh("\n\n-==Skull==-\nby IgnoreIntuition\nLocked and stocked")
  printh(stat(93) .. ":" .. stat(94) .. ":" .. stat(95))
  printh("mem usage: " .. stat(0))
  printh("CPU: " .. stat(1))
end