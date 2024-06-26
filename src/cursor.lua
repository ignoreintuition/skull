Cursor = entity:new({
  x = 16,
  y = 120,
  spr = 32,
  visible = true,
  highlightedStack = 0,
  init = function(_ENV, self)
    self.x = 16
    self.y = 120
    self.highlightedStack = 1
  end,
  update = function(_ENV)
    local gameScene = state:get()
    if state.activeToolbar then
      visible = true
      for k, v in ipairs(gameScene.toolbars[#gameScene.toolbars].tools) do
        if v.active then
          x = 32 + (k - 1) * 10
          y = 42
        end
      end
    else
      if gameScene.mode == modes.start or gameScene.mode == modes.place then
        visible = true
        local hand = gameScene.players[gameScene.currentPlayer].hand
        x = (hand.selectedCard - 1) * 16 + 8
        y = 120
      elseif gameScene.mode == modes.revelation then
        visible = true
        x = seats[highlightedStack].x + 16
        y = seats[highlightedStack].y + 16
      elseif gameScene.mode == modes.challenge then
        visible = false
      end
    end
  end,
  draw = function(_ENV)
    if visible then
      spr(32, x, y, 1, 1)
    end
  end,
  selectNextCard = function(_ENV, dir)
    local gameScene = state:get()
    local hand = gameScene.players[gameScene.currentPlayer].hand
    hand.selectedCard = getNext(hand.selectedCard, #hand.cards, dir)
  end,
  selectStack = function(_ENV, player)
    local gameScene = state:get()
    highlightedStack = player
  end,
  selectNextStack = function(_ENV, dir)
    local gameScene = state:get()
    highlightedStack = getNext(highlightedStack, gameScene.playerCnt, dir)
  end,
  selectToolbar = function(_ENV)
  end
})