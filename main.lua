
display.setStatusBar( display.HiddenStatusBar ) 

-- require controller module
local storyboard = require "storyboard"
local larguraTela = display.contentWidth;
local alturaTela = display.contentHeight;
local bg1 = display.newImage("imagens/sky1.png", true)
bg1.x = larguraTela/2; 
bg1.y = 350;

local jogar = display.newImage ("imagens/iniciar.png")
jogar.x = larguraTela/2; jogar.y = 400;


function jogar:touch(event)
	storyboard.gotoScene("jogo")
end
jogar:addEventListener("touch",jogar)



