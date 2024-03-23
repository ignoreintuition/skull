State = entity:new({
  current = 'game',
  previous = current,
  activeDialog = false,
  activeToolbar = false,
  scenes = {},
  init = function(_ENV, self)
    scenes.game = GameScene:new()
    scenes.title = Title:new()
    scenes.gameOver = GameOver:new()
    scenes.settings = Settings:new()
  end,
  update = function(_ENV)
    if stateChange() then
      scenes[current]:init()
      previous = current
    end
    current = scenes[current]:update()
  end,
  get = function(_ENV)
    return scenes[current]
  end,
  set = function(_ENV, newState)
    current = newState
  end,
  getCurrent = function(_ENV)
    return current
  end,
  stateChange = function()
    return previous != current
  end
})