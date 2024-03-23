function _init()
  state = State:new({
    current = 'title'
  })
  controller = Controller:new()
  printMeta()
end

function _update()
  controller:update()
  state:update()
end

function _draw()
  state:get():draw()
end

function printMeta()
  printh("\n\n-==Skull==-\nby IgnoreIntuition\nLocked and stocked")
  printh(stat(93) .. ":" .. stat(94) .. ":" .. stat(95))
  printh("mem usage: " .. stat(0))
  printh("CPU: " .. stat(1))
end