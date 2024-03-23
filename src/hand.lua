Hand = entity:new({
  cards = {},
  selectedCard = 1,
  init = function(_ENV, self)
    self.cards = {}
    for k, v in pairs(startingHand) do
      add(
        self.cards, Card:new({
          face = v,
          x = k * 16,
          y = 112
        })
      )
    end
  end,
  update = function(_ENV)
    for k, v in pairs(cards) do
      v:update({ x = k * 16, y = 112 })
    end
  end,
  draw = function(_ENV)
    for v in all(cards) do
      v:draw()
    end
  end,
  removeCard = function(_ENV)
    return del(cards, cards[selectedCard])
  end,
  playCard = function(_ENV, player)
    cards[selectedCard]:play(player)
    card = removeCard(_ENV)
    selectedCard = 1
    return card 
  end
})