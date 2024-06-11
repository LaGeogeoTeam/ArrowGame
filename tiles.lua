tile1 = love.graphics.newImage("assets/images/1.png") -- herbe
tile2 = love.graphics.newImage("assets/images/2.png") -- arbre
tile3 = love.graphics.newImage("assets/images/3.png") -- arbreX4


function get_tile_by_id(id)
	if     id == 1 then return tile1
	elseif id == 2 then return tile2
	elseif id == 3 then return tile3
	else return tile1 end
end