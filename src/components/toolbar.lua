Toolbar = entity:new({
  tools = {
    { name = 'challenge', icon = 33, active = true },
    { name = 'raise', icon = 34, active = false },
    { name = 'pass', icon = 35, active = false },
    { name = 'cancel', icon = 36, active = false }
  },
  func = {
    challenge = function()
      state:get():challenge()
    end,
    raise = function()
      state:get():raise()
    end,
    pass = function()
      state:get():pass()
    end,
    cancel = function()
    end
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
  selectNext = function(_ENV, dir)
    local currentTool = 0
    for k, v in ipairs(tools) do
      if v.active == true then
        currentTool = k
      end
    end
    tools[currentTool].active = false
    tools[getNext(currentTool, #tools, dir)].active = true
  end,

  action = function(_ENV)
    for k, v in ipairs(tools) do
      if v.active == true then
        func[v.name]()
      end
    end
  end
})