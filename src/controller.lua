Controller = entity:new({
  init = function(_ENV)
  end,
  update = function(_ENV, game)
    if btnp(4) then
      gameScene.players[1].hand:removeCard(1)
    end
    if btnp(5) then
      gameScene.players[1].active = not gameScene.players[1].active
      gameScene.players[2].active = not gameScene.players[2].active
    end
  end
})