Controller = entity:new({
  inputHandlers = {
    game = function(_ENV)
      if state.activeDialog then
        handleDialog(_ENV)
      elseif state.activeToolbar then
        handleToolbar(_ENV)
      elseif state.activeWidget then
        handleWidget(_ENV)
      else
        handlePlay(_ENV)
      end
    end,
    title = function(_ENV)
      if btnp(4) then
        state:set('game')
      elseif btnp(5) then
        state:set('settings')
      end
    end,
    gameOver = function(_ENV)
    end,
    settings = function(_ENV)
      local settingScene = state:get()
      if btnp(5) then
        state:set('title')
      elseif btnp(1) then
        state.playerCnt = state.playerCnt % 6 + 1
        if state.playerCnt == 1 then 
          state.playerCnt += 1
        end
      end
    end
  },
  init = function(_ENV)
  end,
  update = function(_ENV, game)
    inputHandlers[state:getCurrent()](_ENV)
  end,
  handleDialog = function(_ENV)
    local gameScene = state:get()
    local dialogs = gameScene.dialogs
    if btnp(4) then
      dialogs[#dialogs].cb()
      del(dialogs, dialogs[#gameScene.dialogs])
      state.activeDialog = #dialogs == 1
    end
  end,
  handleToolbar = function(_ENV)
    local gameScene = state:get()
    local toolbars = gameScene.toolbars
    if btnp(5) then
      del(toolbars, toolbars[#toolbars])
      state.activeToolbar = #toolbars == 1
    elseif btnp(4) then
      toolbars[#toolbars]:action()
      del(toolbars, toolbars[#toolbars])
      state.activeToolbar = #toolbars == 1
    elseif btnp(1) then
      toolbars[#toolbars]:selectNext()
    elseif btnp(0) then
      --TODO move left
    end
  end,
  handleWidget = function(_ENV)
    local gameScene = state:get()
    local widgets = gameScene.widgets
    if btnp(5) then
      del(widgets, widgets[#widgets])
      state.activeWidget = #widgets == 1
    elseif btnp(4) then
      widgets[#widgets]:action()
      del(widgets, widgets[#widgets])
      state.activeWidget = #widgets == 1
    elseif btnp(1) then
      widgets[#widgets]:increase()
    elseif btnp(0) then
      widgets[#widgets]:decrease()
    end
  end,
  handlePlay = function(_ENV)
    local gameScene = state:get()
    local mode = gameScene.mode
    if btnp(4) then
      if mode == modes['start'] or mode == modes['place'] then
        if not gameScene:play() then
          gameScene:action()
        end
      elseif mode == modes['revelation'] then
        gameScene:play()
      end
    elseif btnp(5) then
      gameScene:action()
    elseif btnp(1) then
      if gameScene.mode == modes.start or gameScene.mode == modes.place then
        gameScene.cursor:selectNextCard()
      elseif gameScene.mode == modes.revelation then
        gameScene.cursor:selectNextStack()
      end
    elseif btn(0) then
      -- TODO move left
    end
  end
})