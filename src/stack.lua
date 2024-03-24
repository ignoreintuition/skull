Stack = entity:new({
  cards = {},
  playerNumber = 1,
  init = function(_ENV, self)
    self.cards = {}
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
    local x = seats[playerNumber].x
    local y = seats[playerNumber].y
    rectfill(x+ 12, y+ 12, x + 20, y + 20, 0)
    print(#cards, x + 15, y + 14, 7)
  end,
  removeCard = function(_ENV, number)
    del(cards, cards[number])
  end,
  addCard = function(_ENV, card)
    add(cards, card)
  end
})