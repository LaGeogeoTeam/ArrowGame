local menu = {}

-- Liste des sprites de personnages avec genres
local characters = {
    {name = "Warrior", male = "assets/images/characters/warrior_m.png", female = "assets/images/characters/warrior_f.png"},
    {name = "Healer", male = "assets/images/characters/healer_m.png", female = "assets/images/characters/healer_f.png"},
    {name = "Mage", male = "assets/images/characters/mage_m.png", female = "assets/images/characters/mage_f.png"},
    {name = "Ninja", male = "assets/images/characters/ninja_m.png", female = "assets/images/characters/ninja_f.png"},
	{name = "Ranger", male = "assets/images/characters/ranger_m.png", female = "assets/images/characters/ranger_f.png"},
    -- Ajoutez ici d'autres personnages si nécessaire
}

-- Variables pour le menu
local selectedCharacter = 1
local selectedGender = "male"  -- Par défaut "male"

function menu.load()
    txt = {}
    txt.title = "MON JEU"
    txt.msg = "Press space to start"
    bg = love.graphics.newImage("assets/images/bgmenu.png")

    -- Charger les images des personnages
    for _, character in ipairs(characters) do
        character.maleImage = love.graphics.newImage(character.male)
        character.femaleImage = love.graphics.newImage(character.female)
    end
end

function menu.update(dt)
    -- Gestion de la sélection de personnage avec les touches de flèche
    if love.keyboard.isDown("left") then
        selectedCharacter = selectedCharacter - 1
        if selectedCharacter < 1 then
            selectedCharacter = #characters
        end
        love.timer.sleep(0.2)  -- Petit délai pour éviter la sélection rapide
    elseif love.keyboard.isDown("right") then
        selectedCharacter = selectedCharacter + 1
        if selectedCharacter > #characters then
            selectedCharacter = 1
        end
        love.timer.sleep(0.2)  -- Petit délai pour éviter la sélection rapide
    elseif love.keyboard.isDown("up") or love.keyboard.isDown("down") then
        if selectedGender == "male" then
            selectedGender = "female"
        else
            selectedGender = "male"
        end
        love.timer.sleep(0.2)  -- Petit délai pour éviter la sélection rapide
    end
end

function menu.draw()
    love.graphics.draw(bg, 0, 0, 0, 1, 1)
    love.graphics.setFont(fontBig)
    love.graphics.print(txt.title, 460, 40, 0, 2, 2)
    love.graphics.setFont(font)
    love.graphics.print(txt.msg, 420, 600, 0, 1.5, 1.5)

    -- Afficher le personnage sélectionné
    local character = characters[selectedCharacter]
    local image = (selectedGender == "male") and character.maleImage or character.femaleImage
    local scale = 2
    local x = 600 - (image:getWidth() * scale / 2)
    local y = 400 - (image:getHeight() * scale / 2)
    local width, height = image:getWidth() * scale, image:getHeight() * scale

    -- Dessiner le carré de fond coloré
    love.graphics.setColor(0, 0, 0, 0.5) -- noir semi-transparent
    love.graphics.rectangle("fill", x - 20, y - 20, width + 40, height + 40)
    love.graphics.setColor(1, 1, 1, 1) -- réinitialiser la couleur au blanc

    -- Dessiner l'image du personnage sélectionné
    love.graphics.draw(image, x, y, 0, scale, scale)

    -- Afficher le genre sélectionné
    love.graphics.print("Gender: " .. selectedGender, 720, 300, 0, 1, 1)
    -- Afficher le nom du personnage sélectionné
    love.graphics.print("Character: " .. character.name, 720, 250, 0, 1, 1)
	
	-- Afficher l'aide en bas à gauche
    love.graphics.setFont(fontSmall)
    love.graphics.print("Left/Right: Change character", 10, love.graphics.getHeight() - 50)
    love.graphics.print("Up/Down: Change gender", 10, love.graphics.getHeight() - 30)
end

function menu.keypressed(key)
    if key == 'space' then
        -- Mettre à jour la sprite_sheet du joueur avec le personnage et le genre sélectionnés
        local character = characters[selectedCharacter]
        local imagePath = (selectedGender == "male") and character.male or character.female
        player.sprite_sheet = love.graphics.newImage(imagePath)
        player.sprite = love.graphics.newQuad(0, player.yline, 32, 36, player.sprite_sheet:getDimensions())
        scene = "Map1"
    end
end

return menu
