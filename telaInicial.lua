
display.setStatusBar( display.HiddenStatusBar ) 

-- require controller module
local storyboard = require "storyboard"
local scene = storyboard.newScene()

local function iniciar(self, event)
	if event.phase == "began" then
		storyboard.gotoScene("jogo")
		return true
	end
end

function scene:createScene( event )
	local larguraTela = display.contentWidth;
	local alturaTela = display.contentHeight;
	local bg1 = display.newImage("imagens/sky1.png", true)
	bg1.x = larguraTela/2; 
	bg1.y = 350;
	jogar = display.newImage ("imagens/iniciar.png")
	jogar.x = larguraTela/2; jogar.y = 400;
	jogar.touch = iniciar
end

function scene:enterScene( event )
		jogar:addEventListener( "touch", jogar )
	
end

function scene:exitScene( event )
	jogar:removeEventListener( "touch", bg1 )
end

function scene:destroyScene( event )
	
end

scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

return scene







