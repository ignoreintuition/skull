State = entity:new({
  current = 'title',
  previous = 'title',
  playerCnt = 6,
  winner = 0,
  activeDialog = false,
  activeToolbar = false,
  activeWidget = false,
  scenes = {},
  init = function(_ENV, self)
    scenes.title = Title:new({ playerCnt = playerCnt })
    scenes.gameOver = GameOver:new({ playerCnt = playerCnt })
    scenes.settings = Settings:new({ playerCnt = playerCnt })
    scenes.game = GameScene:new({ playerCnt = playerCnt })
  end,
  update = function(_ENV)
    if stateChange(_ENV) then
      scenes[current]:init({ playerCnt = playerCnt  })
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
  stateChange = function(_ENV)
    return previous != current
  end
})