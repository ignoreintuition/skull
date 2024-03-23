Controller = entity:new({
  inputHandlers = {
    game = function(_ENV)
      if state.activeDialog then
        handleDialog(_ENV)
      elseif state.activeToolbar then
        handleToolbar(_ENV)
      else
        handlePlay(_ENV)
      end
    end,
    title = function(_ENV)
      if btnp(4) then
        state:set('game')
      end
    end,
    gameOver = function(_ENV)
    end,
    settings = function(_ENV)
    end
  },
  init = function(_ENV)
  end,
  update = function(_ENV, game)
    inputHandlers[state:getCurrent()](_ENV)
  end,
  handleDialog = function(_ENV)
    local gameScene = state:get()
    if btnp(4) then
      gameScene.dialogs[#gameScene.dialogs].cb()
      del(gameScene.dialogs, gameScene.dialogs[#gameScene.dialogs])
      state.activeDialog = #gameScene.dialogs == 1
    end
  end,
  handleToolbar = function(_ENV)
    local gameScene = state:get()
    if btnp(5) then
      del(gameScene.toolbars, gameScene.toolbars[#gameScene.toolbars])
      state.activeToolbar = #gameScene.toolbars == 1
    elseif btnp(1) then
      gameScene.toolbars[#gameScene.toolbars]:selectNext()
    elseif btnp(0) then
      -- move left
    end
  end,
  handlePlay = function(_ENV)
    local gameScene = state:get()
    if btnp(4) then
      gameScene:play()
    elseif btnp(5) then
      gameScene:action()
    elseif btnp(1) then
      gameScene.cursor:selectCard()
    elseif btn(0) then
      -- move left
    end
  end
})