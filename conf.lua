--conflict test
--conflict test2
--conflict test3

function love.conf(conf)
	 --print(love.window.setMode(nil, nil, {resizable = true}))
	 --conf.window.resizable = true

	 if true then --q&d window positioning.
		  

		conf.window.display = 2
		--conf.window.x = 840
		conf.window.x = 1680
		conf.window.y = 50
		conf.window.width = 840
		conf.window.height = 1000
	 end
end
