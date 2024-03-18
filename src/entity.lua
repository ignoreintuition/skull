global=_ENV

class=setmetatable({
	new=function(_ENV,tbl)
		tbl=tbl or {}
		
		setmetatable(tbl,{
			__index=_ENV
		})
    init(_ENV, tbl)	
		return tbl
	end,
	
	init=function()end
},{__index=_ENV})

entity=class:new({
	x=0,
	y=0,
})