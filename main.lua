-- Includes
Object = require "classic"
require "collision"
require "settings"
require "tiles"
require "inventory"
require "screens/allscreens"
require "player"
require "arrow"

-- Variables
key = love.graphics.newImage("assets/images/key.png")
heart = love.graphics.newImage("assets/images/heart.png")
mob = love.graphics.newImage("assets/images/snake.png")

-- Police écriture
font = love.graphics.newFont("assets/fonts/Bebas.ttf", 35)
fontBig = love.graphics.newFont("assets/fonts/Bebas.ttf", 55)
sfx = love.audio.newSource("assets/sfx/plop.wav", "static")
music = love.audio.newSource("assets/sfx/music.ogg", "stream")

arrowList = {}
mobX = 900
mobY = 400

-- Fonctions Love2D
function love.load() -- Start
	-- Pour avoir un random aléatoire
	math.randomseed(os.time())
	menu.load()
	music:setLooping(true)
	-- music:play()
end


function love.update(dt) -- Tourne en boucle
	update_current_screen(dt)

	if scene ~= "Menu" then
		input_utilisateur(dt)

		for i, v in ipairs(arrowList) do
			v:update(dt)
			if(checkCollision(900, 400, 64, 64, v.x, v.y, 5, 5)) then
				mobY = 10000
			end
		end

		-- Gestion de l'anim du perso
		player.anim_timer = player.anim_timer - dt
		if player.anim_timer <= 0 then
			player.anim_timer = 0.1
			player.frame = player.frame + 1
			if player.frame > player.max_frame then player.frame = 1 end
			offset = 32 * player.frame
			player.sprite:setViewport(offset, player.yline, 32, 36)
		end
	end
end


function love.draw() -- Dessine le contenu
	draw_current_screen()
	love.graphics.setFont(font)

	if scene ~= "Menu" then
		love.graphics.draw(player.sprite_sheet, player.sprite, player.posX, player.posY, 
			player.r, player.xscale, player.yscale, 16, 18)

		love.graphics.draw(key, 10, 10, 0, 0.1, 0.1)
		love.graphics.draw(mob, mobX, mobY, 0, 0.75, 0.75)
		love.graphics.draw(heart, 1180, 15, 0, 1.5, 1.5)
		love.graphics.print(keycount, 80, 20)

		for i, v in ipairs(arrowList) do 
			v:draw()
		end
	end
end


function love.keypressed(key)
	check_key_current_screen(key)
end

-- Fonctions perso

function input_utilisateur(dt)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	-- Si on appuie sur espace
	-- if love.keyboard.isDown("space") then
	-- 	table.insert(arrowList, Arrow(player.posX, player.posY, arrowR))
	-- end

	-- Si on appuie sur clic droit
	if love.mouse.isDown(1) and not mousePressed then
        mousePressed = true
        local mouseX = love.mouse.getX()
        local mouseY = love.mouse.getY()
        local arrowR = math.atan2(mouseY - player.posY, mouseX - player.posX)
        table.insert(arrowList, Arrow(player.posX, player.posY, arrowR))
    end

    if not love.mouse.isDown(1) then
        mousePressed = false
    end

	if love.keyboard.isDown("up") and player.posY > 32 then
		player.posY = player.posY - player.speed * dt
		player.yline = 0
		player.max_frame = 2
	elseif love.keyboard.isDown("down") and player.posY < 720 then
		player.posY = player.posY + player.speed * dt
		player.yline = 36 * 2
		player.max_frame = 2
	elseif love.keyboard.isDown("left") and player.posX > 32 then
		player.posX = player.posX - player.speed * dt
		player.yline = 36 * 3
		player.max_frame = 2
	elseif love.keyboard.isDown("right") and player.posX < 1250 then
		player.posX = player.posX + player.speed * dt
		player.yline = 36
		player.max_frame = 2
	else
		player.max_frame = 1
	end
end

function check_player_collisions()
	-- if checkCollision(player.posX-(player.size/2), player.posY-(player.size/2), player.size, player.size, enemy.x-32, enemy.y-32, 64, 64) then
	-- end
end

function update_current_screen(dt)
	if scene == "Menu" then
		menu.update(dt)
	elseif scene == "Map1" then
		firstmap.update(dt)
	elseif scene == "Map2" then
		secondmap.update(dt)
	end
end

function draw_current_screen()
	if scene == "Menu" then
		menu.draw()
	elseif scene == "Map1" then
		firstmap.draw()
	elseif scene == "Map2" then
		secondmap.draw()
	end
end

function check_key_current_screen(key)
	if scene == "Menu" then
		menu.keypressed(key)
	end
end