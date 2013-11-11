
display.setStatusBar( display.HiddenStatusBar ) 

-- require controller module
local storyboard = require "storyboard"
local larguraTela = display.contentWidth;
local alturaTela = display.contentHeight;
local bg1 = display.newImage("imagens/sky.png", true)
bg1.x = larguraTela/2; 
bg1.y = alturaTela/2;

local jogar = display.newImage ("imagens/btn_arrow.png")
jogar.x = larguraTela/2; jogar.y = alturaTela/2;
jogar.rotation = 270



function jogar:touch(event)
	storyboard.gotoScene("jogo")
end
jogar:addEventListener("touch",jogar)



