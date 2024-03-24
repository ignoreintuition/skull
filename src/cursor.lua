Cursor = entity:new({
  x = 16,
  y = 120,
  spr = 32,
  init = function(_ENV, self)
  end,
  update = function(_ENV)
    local gameScene = state:get()
    if state.activeToolbar then
      for k, v in ipairs(gameScene.toolbars[#gameScene.toolbars].tools) do
        if v.active then
          x = 32 + (k - 1) * 10
          y = 42
        end
      end
    else
      local hand = gameScene.players[gameScene.currentPlayer].hand
      x = (hand.selectedCard - 1) * 16 + 8
      y = 120
    end
  end,
  draw = function(_ENV)
    spr(32, x, y, 1, 1)
  end,
  selectNextCard = function(_ENV, dir)
    local gameScene = state:get()
    local hand = gameScene.players[gameScene.currentPlayer].hand
    hand.selectedCard = hand.selectedCard % #hand.cards + 1
  end,
  selectToolbar = function(_ENV)
  end
})