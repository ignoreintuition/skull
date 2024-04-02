GameScene = Scene:new({
  name = 'game',
  mode = modes.start,
  players = {},
  playerCnt = 6,
  currentPlayer = 1,
  round = 1,
  roundOver = false,
  currentBid = 0,
  maxBid = 0,
  revealed = 0,
  out = false,

  selectedStack = {},
  currentPlayerStack = {},

  cursor = {},
  dialogs = {},
  toolbars = {},
  widgets = {},

  init = function(_ENV, self)
    mode = modes.start
    players = {}
    currentPlayer = 1
    round = 1
    roundOver = false
    currentBid = 0
    maxBid = 0
    revealed = 0
    out = false
    selectedStack = {}
    currentPlayerStack = {}
    cursor = {}
    mode = modes.start
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
    if players[currentPlayer].out == true then
      nextPlayer(_ENV)
    end
    ui:update()
    cursor:update()
    callAll(players, 'update')
    callAll(dialogs, 'update')
    callAll(toolbars, 'update')
    callAll(widgets, 'update')
    local active = 0
    for k, v in pairs(players) do
      if v.challenger or v.passed or v.out then
        active += 1
      end
    end
    if revelation(_ENV, active) then
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
    maxBid = 0
    for v in all(players) do
      maxBid += #v.stack.cards
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
    local text = ""
    if currentPlayer == #players and mode == modes.start then
      mode = modes.place
    end
    if currentBid == maxBid and mode == modes.challenge then
      text = "max bid\nshow cards"
    else
      repeat
        currentPlayer = currentPlayer % #players + 1
      until not players[currentPlayer].passed == true and not players[currentPlayer].out == true
      for k, v in ipairs(players) do
        v.active = currentPlayer == k
      end
      text = "pass to " .. "\nplayer " .. currentPlayer
    end
    add(
      dialogs, Dialog:new({
        text = text,
        cancellable = false,
        cb = function()
        end
      })
    )
    state.activeDialog = true
  end,
  challenge = function(_ENV)
    add(
      widgets, Widget:new({
        cb = function()
          mode = modes.challenge
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
      selectedStack = players[cursor.highlightedStack].stack.cards
      currentPlayerStack = players[currentPlayer].stack.cards
      if canPlay(_ENV) then
        revealed += 1
        if selectedStack[#selectedStack].face == skull then
          players[currentPlayer].losses += 1
          players[currentPlayer].lostRound = true
          add(
            dialogs, Dialog:new({
              text = 'skull!\nyou lose\n\none card\nremoved\nfrom hand',
              cancellable = false,
              cb = function()
                nextRound(_ENV)
              end
            })
          )
        else
          if revealed == currentBid then
            players[currentPlayer].wins += 1
            if players[currentPlayer].wins == 2 then
              add(
                dialogs, Dialog:new({
                  text = 'game over\nwinner is\nplayer ' .. currentPlayer,
                  cancellable = false,
                  cb = function()
                    state.winner = currentPlayer
                    state.current = 'gameOver'
                  end
                })
              )
            else
              add(
                dialogs, Dialog:new({
                  text = 'player ' .. currentPlayer .. '\nwins the\nround',
                  cancellable = false,
                  cb = function()
                    nextRound(_ENV)
                  end
                })
              )
            end
          else
            add(
              dialogs, Dialog:new({
                text = 'rose!\n\n' .. currentBid - revealed .. ' more\ncard(s)\nremaining',
                cancellable = false,
                cb = function()
                  selectedStack[#selectedStack].inHand = true
                  add(players[cursor.highlightedStack].hand.cards, selectedStack[#selectedStack])
                  del(selectedStack, selectedStack[#selectedStack])
                end
              })
            )
          end
        end
        state.activeDialog = true
      else
        add(
          dialogs, Dialog:new({
            text = 'please\nselect\na valid\nmove',
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
  end,
  canPlay = function(_ENV)
    if revealed >= currentBid then
      return false
    elseif cursor.highlightedStack == currentPlayer and #selectedStack > 0 then
      return true
    elseif #selectedStack > 0 and #currentPlayerStack == 0 then
      return true
    end
    return false
  end,
  nextRound = function(_ENV)
    currentBid = 0
    revealed = 0
    round = round + 1
    mode = modes.start
    for k, v in ipairs(players) do
      local playerToDel = 0
      v.challenger = false
      v.passed = false
      for j, w in ipairs(v.stack.cards) do
        w.inHand = true
        add(v.hand.cards, w)
      end
      for j, w in pairs(v.stack.cards) do
        v.stack.cards[j] = nil
      end
      if v.lostRound == true then
        local cardToDel = flr(rnd(#v.hand.cards)) + 1
        deli(v.hand.cards, cardToDel)
        v.lostRound = false
        if #v.hand.cards == 0 then
          playerToDel = k
        end
      end
      if playerToDel > 0 then
        players[playerToDel].out = true
      end
    end
    local playersOut = 0
    for k, v in ipairs(players) do
      if v.out == true then
        playersOut += 1
      end
    end
    if playersOut == #players - 1 then
      state.current = 'gameOver'
      state.winner = currentPlayer
    end
  end,
  revelation = function(_ENV, active)
    if active == #players then
      return true
    elseif mode == modes.challenge and currentBid == maxBid then
      return true
    end
    return false
  end
})