display.setStatusBar( display.HiddenStatusBar ) 

local storyboard = require("storyboard")
scene = storyboard.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0, 10)
larguraTela = display.contentWidth;
alturaTela = display.contentHeight;
motionX= 0; -- movimento no eixo x
velocidade = 5; --velocidade do jogador
--lifes = 5 --vidas jogador
--score = 0 --pontuacao

-- Add backgrounds
local bg1 = display.newImage("imagens/sky.png", true)
bg1.x = larguraTela/2; 
bg1.y = 50;

local bg2 = display.newImage("imagens/bg2.png")
bg2.x = larguraTela/2; 
bg2.y = alturaTela/2;

local bg2_2 = display.newImage("imagens/bg2.png")
bg2.x = larguraTela/2; 
bg2.y = alturaTela/2;


-- Add chão
local floor = display.newImage( "imagens/floor.png")
floor.x = larguraTela/2; floor.y = alturaTela-15;
physics.addBody( floor, "static", { friction=100, bounce=0.3 } )

-- Add Jogador		
local player = display.newImage( "imagens/playerparado.png" )
physics.addBody(player , "dynamic", { friction=-500,density=4000, bounce=-110, radius= 40} ) 
player.x = display.contentWidth/2
player.y= 450

--paredes
paredeEsquerda = display.newRect( 0, -200, 1, 800)
paredeDireita = display.newRect(display.contentWidth,-150,10, 800)
teto = display.newRect(0,-250,display.contentWidth,1)
chao = display.newRect(display.contentWidth,-250,display.contentWidth,1)


--physics.addBody(paredeEsquerda, "static", {bounce = 0.1 })
--physics.addBody(paredeDireita, "static", {bounce = 0.1 })
--physics.addBody(teto, "static", {bounce = 0.5 })

--local function updateScore(num)
--	score= score + num
--	textScore.text = "Score " .. score
--	textScore:setReferencePoint(display.TopLeftReferencePoint)
--	textScore.x = display.contentWidth - 310
--end

-----------------------------------------------------------------Botoes-----------------------------------------------------------------------
-- Add Botao Cima
local up = display.newImage ("imagens/btn_arrow.png")
	up.x = 100; up.y = 400;
	up.rotation = 270

-- Add Botao Esquerdo
local botaoEsquerdo= display.newImage ("imagens/btn_arrow.png")
	botaoEsquerdo.y = 450; botaoEsquerdo.x = 50;
	botaoEsquerdo.rotation = 180;

-- Add Botao Direito
	local botaoDireito = display.newImage ("imagens/btn_arrow.png")
	botaoDireito.x = 150; botaoDireito.y = 452;
	
-- Add Botao Tiro
	local botaoShoot = display.newImage ("imagens/shoot.png")
	botaoShoot.x = 900;	botaoShoot.y = 450;
----------------------------------------------------------------------------------------------------------------------------------------------
	
	
-----------------------------------------------------------------Acoes-----------------------------------------------------------------------	
--anima cenario
local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	motionX = velocidade;
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )

	bg1.x = bg1.x - xOffset
	bg2.x = bg2.x - xOffset
	bg2_2.x = bg2_2.x - xOffset

	if (bg2.x + bg2.contentWidth) < 0 then
		bg2:translate( 960 * 2, 0)
	end
	if (bg2_2.x + bg2_2.contentWidth) < 0 then
		bg2_2:translate( 960 * 2, 0)
	end
end




-- Stop 
local function stop (event)
	if event.phase =="ended" then
		motionX = 0;
	end		
end
Runtime:addEventListener("touch", stop )

-- Mover jogador
local function moveplayer (event)
	player.x = player.x + motionX;
end
Runtime:addEventListener("enterFrame", moveplayer)

-- Pula
function up:touch(event)
	if event.phase == "began"  then
		player:setLinearVelocity( 0, -200 );
	end
end
up:addEventListener("touch",up)

-- Move jogador para esquerda
local function moveEsquerda (event)
	motionX = -velocidade;
end
botaoEsquerdo:addEventListener("touch",moveEsquerda)

-- Move jogador para direita
local function moveDireita (event)
	motionX = velocidade;
end
--botaoDireito:addEventListener("touch",moveDireita)
botaoDireito:addEventListener("touch",move)
--atirar
local shot
local function atirar()
	--n = n + 1
	--shots[n] = display.newImage( "imagens/tiro.png", player.x, player.y-8 );
	shot = display.newImage( "imagens/tiro.png", player.x+5, player.y-25 )
	--physics.addBody( shots[n], { density=3.0, friction=0.5, bounce=0.05 } );
	physics.addBody( shot, { density=0.0, friction=0.5, bounce=0.05 } )
	--shots[n].isBullet = true;
	shot.isBullet = false
	shot:applyForce( 1200, 0, shot.x, shot.y )
	shot.angularVelocity = 100;
	--shots[n].angularVelocity = 100;
	--shots[n]:applyForce( 1200, 0, shots[n].x, shots[n].y );
end
botaoShoot:addEventListener("touch",atirar)
--------------------------------------------------------------------------------------------------------------------------------------
return scene
