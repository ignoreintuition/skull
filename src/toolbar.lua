Toolbar = entity:new({
  tools = {
    { name = 'challenge', icon = 33, active = true },
    { name = 'raise', icon = 34, active = false },
    { name = 'pass', icon = 35, active = false },
    { name = 'cancel', icon = 36, active = false }
  },
  init = function(_ENV, self)
    local gameScene = state:get()
  end,
  update = function(_ENV)
  end,
  draw = function(_ENV)
    rectfill(19, 29, 81, 61, 7)
    rectfill(20, 30, 80, 60, 0)
    for k, v in ipairs(tools) do
      spr(v.icon, (k - 1) * 10 + 34, 34, 1, 1)
      if v.active == true then
        print(v.name, 25, 52, 7)
      end
    end
  end,
  selectNext = function(_ENV)
    local currentTool = 0
    for k, v in ipairs(tools) do
      if v.active == true then
        currentTool = k
      end
    end
    tools[currentTool].active = false
    tools[currentTool % #tools + 1].active = true
  end
})