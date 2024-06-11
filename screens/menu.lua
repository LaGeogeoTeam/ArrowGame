local menu = {}

function menu.load()
	txt = {}
	txt.title = "MON JEU"
	txt.msg = "Press space to start"
	bg = love.graphics.newImage("assets/images/bgmenu.png")
end

function menu.update(dt)

end

function menu.draw()
	love.graphics.draw(bg, 0, 0, 0, 1, 1)
	love.graphics.setFont(fontBig)
	love.graphics.print(txt.title, 460, 40, 0, 2.5, 2.5)
	love.graphics.setFont(font)
	love.graphics.print(txt.msg, 400, 360, 0, 2, 2)
end

function menu.keypressed(key)
	if key == 'space' then
		scene = "Map1"
	end
end

return menu