Stack = entity:new({
  cards = {},
  init = function(_ENV, self)
    self.cards = {}
  end,
  update = function(_ENV)
    for v in all(cards) do
      v:update()
    end
  end,
  draw = function(_ENV, active)
    for v in all(cards) do
      v:draw()
    end
  end,
  removeCard = function(_ENV, number)
    del(cards, cards[number])
  end,
  addCard = function(_ENV, card)
    add(cards, card)
  end
})