GameScene = Scene:new({
  name = 'game',
  mode = modes.start,
  players = {},
  playerCnt = 6,
  round = 1,
  currentBid = 0,

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
  currentPlayer = 1,
  update = function(_ENV)
    ui:update()
    cursor:update()
    for v in all(players) do
      v:update()
    end
    for v in all(dialogs) do
      v:update()
    end
    for v in all(toolbars) do
      v:update()
    end
    for v in all(widgets) do
      v:update()
    end
    return 'game'
  end,
  draw = function(_ENV)
    ui:draw()
    for v in all(players) do
      v:draw()
    end
    for v in all(dialogs) do
      v:draw()
    end
    for v in all(toolbars) do
      v:draw()
    end
    for v in all(widgets) do
      v:draw()
    end
    cursor:draw()
  end,
  nextPlayer = function(_ENV)
    if currentPlayer == #players and mode == modes.start then
      mode = modes.place
    end
    currentPlayer = currentPlayer % #players + 1
    for k, v in ipairs(players) do
      v.active = currentPlayer == k
    end
  end,
  challenge = function(_ENV)
    mode = modes.challenge
    add(
      widgets, Widget:new({
        cb = function()
          state.activeWidget = false
          add(
            dialogs, Dialog:new({
              text = "player " .. currentPlayer .. "\nissues a\nchallenge",
              cancellable = false,
              cb = function()
                state:get():nextPlayer()
              end
            })
          )
          state.activeDialog = true
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
          add(
            dialogs, Dialog:new({
              text = "player " .. currentPlayer .. "\nraised bid",
              cancellable = false,
              cb = function()
                state:get():nextPlayer()
              end
            })
          )
          state.activeDialog = true
        end
      })
    )
    state.activeWidget = true
  end,
  pass = function(_ENV)
    state:get():nextPlayer()
  end,
  play = function(_ENV)
    players[currentPlayer].stack:addCard(players[currentPlayer].hand:playCard(currentPlayer))
    add(
      dialogs, Dialog:new({
        text = "pass to\nplayer " .. players[currentPlayer % #players + 1].number,
        cancellable = false,
        cb = function()
          nextPlayer(_ENV)
        end
      })
    )
    state.activeDialog = true
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
      add(toolbars, Toolbar:new())
    end
  end
})