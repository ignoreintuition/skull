function find(tbl, val)
  for k, v in pairs(tbl) do
      if v == val then return k end
  end
  return nil
end

function callAll(tbl, fn) 
  for v in all(tbl) do
    v[fn](v)
  end
end