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

function getNext(number, length, iteration)
  number = number + iteration
  if number == 0 then
    return length
  elseif number > length then
    return 1
  end
  return number 
end