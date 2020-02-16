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

local currentTetros = 1
local currentRotation = 1

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
end

function love.update(dt)

end

function love.draw()
    
    local shape = Tetros[currentTetros][currentRotation]

    for l=1, #shape do
        for c=1, #shape[l] do
            local x = (c-1)*32
            local y = (l-1)*32

            if shape[l][c] == 1 then
                love.graphics.rectangle("fill", x, y, 31, 31)
            end
        end
    end

end

function love.keypressed(key)
  
    if key == "r" then
        currentRotation = currentRotation % #Tetros[currentTetros] + 1
    end

    if key == "n" then
        currentTetros = currentTetros % #Tetros + 1
        currentRotation = 1
    end
  
end