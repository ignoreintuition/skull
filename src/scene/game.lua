GameScene = Scene:new({
  name = 'game',
  mode = modes.start,
  players = {},
  playerCnt = 6,
  currentPlayer = 1,
  round = 1,
  currentBid = 0,
  maxBid = 10,
  revealed = 0,

  cursor = {},
  dialogs = {},
  toolbars = {},
  widgets = {},

  init = function(_ENV, self)
    players = {}
    playerCnt = self.playerCnt
    ui = UI:new()
    cursor = Cursor:new()
    for k = 1, playerCnt, 1 do
      add(
        players, Player:new({
          x,
          number = k,
          active = k == 1
        })
      )
    end
  end,
  update = function(_ENV)
    ui:update()
    cursor:update()
    callAll(players, 'update')
    callAll(dialogs, 'update')
    callAll(toolbars, 'update')
    callAll(widgets, 'update')
    local active = 0
    for k, v in pairs(players) do
      if v.challenger or v.passed then
        active += 1
      end
    end
    if active == #players then
      if mode != modes.revelation then
        for k, v in ipairs(players) do
          if v.challenger then
            currentPlayer = k
            for k, v in ipairs(players) do
              v.active = currentPlayer == k
            end
          end
        end
        cursor:selectStack(currentPlayer)
      end
      mode = modes.revelation
    end
    return 'game'
  end,
  draw = function(_ENV)
    ui:draw()
    callAll(players, 'draw')
    callAll(toolbars, 'draw')
    cursor:draw()
    callAll(widgets, 'draw')
    callAll(dialogs, 'draw')
  end,
  nextPlayer = function(_ENV)
    if currentPlayer == #players and mode == modes.start then
      mode = modes.place
    end
    repeat
      currentPlayer = currentPlayer % #players + 1
    until not players[currentPlayer].passed == true
    for k, v in ipairs(players) do
      v.active = currentPlayer == k
    end
    add(
      dialogs, Dialog:new({
        text = "pass to " .. currentPlayer,
        cancellable = false,
        cb = function()
        end
      })
    )
    state.activeDialog = true
  end,
  challenge = function(_ENV)
    mode = modes.challenge
    add(
      widgets, Widget:new({
        cb = function()
          state.activeWidget = false
          state:get():nextPlayer()
        end
      })
    )
    state.activeWidget = true
  end,
  raise = function(_ENV)
    add(
      widgets, Widget:new({
        cb = function()
          state.activeWidget = false
          state:get():nextPlayer()
        end
      })
    )
    state.activeWidget = true
  end,
  pass = function(_ENV)
    local gameScene = state:get()
    gameScene.players[gameScene.currentPlayer].passed = true
    gameScene:nextPlayer()
  end,
  play = function(_ENV)
    if mode == modes.start or mode == modes.place then
      if #players[currentPlayer].hand.cards == 0 then
        return false
      end
      players[currentPlayer].stack:addCard(players[currentPlayer].hand:playCard(currentPlayer))
      nextPlayer(_ENV)
    elseif mode == modes.revelation then
      -- TODO check if all players cards have been revealed
      -- TODO pop cards off the stack
      -- TODO if game end award win or remove card
      if revealed < maxBid then
        add(
          dialogs, Dialog:new({
            text = players[cursor.highlightedStack].stack.cards[#players[cursor.highlightedStack].stack.cards].face,
            cancellable = false,
            cb = function()
            end
          })
        )
        state.activeDialog = true
      end
      return true
    end
    return true
  end,
  action = function(_ENV)
    if mode == modes.start then
      add(
        dialogs, Dialog:new({
          text = "no other\nactions\navailable",
          cancellable = false,
          cb = function()
          end
        })
      )
      state.activeDialog = true
      return true
    elseif mode == modes.place then
      add(
        toolbars, Toolbar:new({
          tools = {
            { name = 'challenge', icon = 33, active = true },
            { name = 'cancel', icon = 36, active = false }
          }
        })
      )
      state.activeToolbar = true
      return true
    elseif mode == modes.challenge then
      add(
        toolbars, Toolbar:new({
          tools = {
            { name = 'raise', icon = 34, active = true },
            { name = 'pass', icon = 35, active = false },
            { name = 'cancel', icon = 36, active = false }
          }
        })
      )
      state.activeToolbar = true
    elseif mode == modes.revelation then
      add(
        dialogs, Dialog:new({
          text = "no other\nactions\navailable",
          cancellable = false,
          cb = function()
          end
        })
      )
      state.activeDialog = true
      return true
    end
  end
})