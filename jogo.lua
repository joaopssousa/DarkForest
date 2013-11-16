display.setStatusBar( display.HiddenStatusBar ) 

local storyboard = require("storyboard")
scene = storyboard.newScene()
storyboard.purgeScene("telaInicial")
local physics = require("physics")
physics.start()
physics.setGravity(0, 10)
local larguraTela = display.contentWidth;
local alturaTela = display.contentHeight;
--Controle personagem
local botaoPula, botaoEsquerdo, botaoDireito, botaoShoot
--Backgrounds
local bg1, bg2
--Jogador
local player
speed = 5;
motionX= 0; -- movimento no eixo x
velocidade = 5; --velocidade do jogador
--lifes = 5 --vidas jogador
--score = 0 --pontuacao

function scene:createScene( event )
	-- Add backgrounds
	local bg1 = display.newImage("imagens/sky.png", true)
	bg1.x = larguraTela - 250; 
	bg1.y = 5;

	bg2 = display.newImage("imagens/bg2.png")
	bg2.x = larguraTela/2; 
	bg2.y = alturaTela/2;

	--local bg2_2 = display.newImage("imagens/bg2.png")
	--bg2.x = -400; 
	--bg2.y = alturaTela/2;

	-- Add chão
	floor = display.newImage( "imagens/floor.png")
	floor.x = larguraTela/2; floor.y = alturaTela-15;
	physics.addBody( floor, "static", { friction=100, bounce=0.3 } )

	-- Add Jogador		
	player = display.newImage( "imagens/playerparado.png" )
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
	physics.addBody(teto, "static", {bounce = 0.5 })

	-----------------------------------------------------------------Botoes-----------------------------------------------------------------------
	-- Add Botao Cima
		botaoPula = display.newImage ("imagens/btn_arrow.png")
		botaoPula.x = 100; botaoPula.y = 400;
		botaoPula.rotation = 270

	-- Add Botao Esquerdo
		botaoEsquerdo= display.newImage ("imagens/btn_arrow.png")
		botaoEsquerdo.y = 450; botaoEsquerdo.x = 50;
		botaoEsquerdo.rotation = 180;

	-- Add Botao Direito
		botaoDireito = display.newImage ("imagens/btn_arrow.png")
		botaoDireito.x = 150; botaoDireito.y = 452;
		
	-- Add Botao Tiro
		botaoShoot = display.newImage ("imagens/shoot.png")
		botaoShoot.x = 900;	botaoShoot.y = 450;
	----------------------------------------------------------------------------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	-----------------------------------------------------------------Acoes-----------------------------------------------------------------------	
	--anima cenario
	local function movimentaCenario(self,event)
		if self.x > 530 then
			self.x = -30
		else
		   self.x = self.x + speed
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
	function pula (event)
		if event.phase == "began"  then
			player:setLinearVelocity( 0, -200 );
		end
	end
	botaoPula:addEventListener("touch",pula)

	-- Move jogador para esquerda
	local function moveEsquerda (event)
		motionX = -velocidade;
	end
	botaoEsquerdo:addEventListener("touch",moveEsquerda)

	-- Move jogador para direita
	local function moveDireita (event)
		motionX = velocidade;
	end
	botaoDireito:addEventListener("touch",moveDireita)
	--botaoDireito:addEventListener("touch",movimentaCenario)
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

	bg2.enterFrame = movimentaCenario
	  Runtime:addEventListener("enterFrame", bg2)
	--------------------------------------------------------------------------------------------------------------------------------------
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene
