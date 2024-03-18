Hand = entity:new({
  startingHand = { skull, flower, flower, flower },
  cards = {},
  init = function(_ENV, self)
    self.cards = {}
    for k, v in pairs(self.startingHand) do
      add(self.cards, Card:new({ face = v, x = k * 16 + 8, y = 112 }))
    end
  end,
  update = function(_ENV)
    for v in all(cards) do
      v:update()
    end
  end,
  draw = function(_ENV)
    for v in all(cards) do
      v:draw()
    end
  end,
  removeCard = function(_ENV, number)
    del(cards, cards[number])
  end,
  playCard = function(_ENV, number)
    
  end
})