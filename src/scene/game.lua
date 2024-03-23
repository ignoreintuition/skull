GameScene = Scene:new({
  name = 'game',
  names = { 'brian', 'zona', 'nick', 'mitch', 'cj', 'matt' },
  round = 1,
  mode = modes.start,
  players = {},
  cursor = {},
  dialogs = {},
  toolbars = {},
  init = function(_ENV)
    ui = UI:new()
    cursor = Cursor:new()
    for k, v in ipairs(names) do
      add(
        players, Player:new({
          name = v,
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
  play = function(_ENV)
    players[currentPlayer].stack:addCard(players[currentPlayer].hand:playCard(currentPlayer))
    add(
      dialogs, Dialog:new({
        text = "pass to\n" .. players[currentPlayer % #players + 1].name,
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