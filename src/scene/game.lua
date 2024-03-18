GameScene = Scene:new({
  name = 'game',
  names = { 'brian', 'zona', 'nick', 'mitch', 'cj', 'matt' },
  round = 1,
  players = {},
  init = function(_ENV)
    ui = UI:new()
    controller = Controller:new()
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
  update = function(_ENV)
    ui:update()
    controller:update()
    for v in all(players) do
      v:update()
    end
    return 'game'
  end,
  draw = function(_ENV)
    ui:draw()
    for v in all(players) do
      v:draw()
    end
  end
})