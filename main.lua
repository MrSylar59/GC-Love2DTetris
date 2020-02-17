-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local Tetros = {}
Tetros[1] = {
    {
        {0,0,0,0},
        {0,0,0,0},
        {1,1,1,1},
        {0,0,0,0}
    },
    {
        {0,1,0,0},
        {0,1,0,0},
        {0,1,0,0},
        {0,1,0,0}
    }
}

Tetros[2] = {
    {
        {0,0,0,0},
        {0,1,1,0},
        {0,1,1,0},
        {0,0,0,0}
    }
}

Tetros[3] = {
    {
        {0,0,0},
        {1,1,1},
        {0,0,1}
    },
    {
        {0,1,0},
        {0,1,0},
        {1,1,0}
    },
    {
        {1,0,0},
        {1,1,1},
        {0,0,0}
    },
    {
        {0,1,1},
        {0,1,0},
        {0,1,0}
    }
}

Tetros[4] = {
    {
        {0,0,0},
        {1,1,1},
        {1,0,0}
    },
    {
        {1,1,0},
        {0,1,0},
        {0,1,0}
    },
    {
        {0,0,1},
        {1,1,1},
        {0,0,0}
    },
    {
        {0,1,0},
        {0,1,0},
        {0,1,1}
    }
}

Tetros[5] = {
    {
        {0,0,0},
        {0,1,1},
        {1,1,0}
    },
    {
        {1,0,0},
        {1,1,0},
        {0,1,0}
    }
}

Tetros[6] = {
    {
        {0,0,0},
        {1,1,1},
        {0,1,0}
    },
    {
        {0,1,0},
        {1,1,0},
        {0,1,0}
    },
    {
        {0,1,0},
        {1,1,1},
        {0,0,0}
    },
    {
        {0,1,0},
        {0,1,1},
        {0,1,0}
    }
}

Tetros[7] = {
    {
        {0,0,0},
        {1,1,0},
        {0,1,1}
    },
    {
        {0,1,0},
        {1,1,0},
        {1,0,0}
    }
}

local currentTetros = {}
currentTetros.shapeID = 1
currentTetros.rotation = 1
currentTetros.position = { x=0, y=0 }

local grid = {}
grid.width = 10
grid.height = 20
grid.offsetX = 0
grid.cellSize = 0
grid.cells = {}

local dropSpeed = 1
local dropTimer = 0

function spawnTetros() 
    local new = math.random(1, #Tetros)
    currentTetros.shapeID = new
    currentTetros.rotation = 1

    local tetrosW = #Tetros[currentTetros.shapeID][currentTetros.rotation][1]
    currentTetros.position.x = math.floor((grid.width - tetrosW)/2)+1
    currentTetros.position.y = 1

    dropTimer = dropSpeed
end

function initGrid() 
    local h = hauteur / grid.height
    grid.cellSize = h
    grid.offsetX = largeur/2 - grid.cellSize*grid.width/2
    grid.cells = {}

    for l=1, grid.height do
        grid.cells[l] = {}
        for c=1, grid.width do
            grid.cells[l][c] = 0
        end
    end
end

function drawGrid() 
    local h = grid.cellSize
    local w = h
    love.graphics.setColor(1, 1, 1, 0.20)

    local x, y
    for l=1, grid.height do
        for c=1, grid.width do
            x = (c-1)*w + grid.offsetX
            y = (l-1)*h
            love.graphics.rectangle("fill", x, y, w-1, h-1)
        end
    end
end

function drawShape(pShape, pCol, pLine) 
    love.graphics.setColor(1, 1, 1, 1)

    local cSize = grid.cellSize

    for l=1, #pShape do
        for c=1, #pShape[l] do
            local x = (c-1) * cSize
            local y = (l-1) * cSize

            -- Ajout position de la pièce dans la grille
            x = x + (pCol-1) * cSize + grid.offsetX
            y = y + (pLine-1) * cSize

            if pShape[l][c] == 1 then
                love.graphics.rectangle("fill", x, y, cSize-1, cSize-1)
            end
        end
    end
end

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    initGrid()
    spawnTetros()
end

function love.update(dt)
    
    -- Gestion d'un timer ~1s
    dropTimer = dropTimer - dt
    if dropTimer <= 0 then
        currentTetros.position.y = currentTetros.position.y + 1
        dropTimer = dropSpeed
    end
end

function love.draw()
    
    local shape = Tetros[currentTetros.shapeID][currentTetros.rotation]

    drawGrid()
    drawShape(shape, currentTetros.position.x, currentTetros.position.y)
end

function love.keypressed(key)
    --[[if key == "n" then
        currentTetros.shapeID = currentTetros.shapeID % #Tetros + 1
        currentTetros.rotation = 1
    end]]

    if key == "right" then
        currentTetros.position.x = currentTetros.position.x + 1
    elseif key == "left" then
        currentTetros.position.x = currentTetros.position.x - 1
    elseif key == "up" then
        currentTetros.rotation = currentTetros.rotation % #Tetros[currentTetros.shapeID] + 1
    end
  
end