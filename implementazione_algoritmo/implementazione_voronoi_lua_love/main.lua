function love.load()
	love.math.setRandomSeed(os.time())

	-- Numero di celle in cui suddividere l'area
	number_cells = 50

	voronoiDiagram = generate_Voronoi(love.graphics.getWidth(), love.graphics.getHeight(), number_cells)
end

function hypot(x, y)
	return math.sqrt(x*x + y*y)
end

function generate_Voronoi(width, height, num_cells)
	io.write("Generazione in corso.."); io.flush()
	canvas = love.graphics.newCanvas(width, height)
	local img_width = canvas:getWidth()
	local img_height = canvas:getHeight()

	-- Vettori contenenti le coordinate dei vari droni
	-- Il drone i avrà coordinate (drone_pos_x[i], drone_pos_y[i])
	local drone_pos_x = {}
	local drone_pos_y = {}

	-- Vettori contenenti i colori delle varie partizioni
	local partition_color_red = {}
	local partition_color_green = {}
	local partition_color_blue = {}

	-- Genero le posizioni dei vari droni e i colori delle rispettive
	-- partizioni
	for a = 1, num_cells do
	   	table.insert(drone_pos_x, love.math.random(0, img_width))
	   	table.insert(drone_pos_y, love.math.random(0, img_height))
	   	table.insert(partition_color_red, love.math.random(0, 255))
	   	table.insert(partition_color_green, love.math.random(0, 255))
	   	table.insert(partition_color_blue, love.math.random(0, 255))
	end

	love.graphics.setColor({ 255, 255, 255 })
	love.graphics.setCanvas(canvas)

	-- Scorro punto per punto tutta la mappa
	for y = 1, img_height do
	   	for x = 1, img_width do
			-- dmin contiene la distanza massima possibile, ovvero la diagonale
			-- del rettangolo
			dmin = hypot(img_width - 1, img_height - 1)
			-- j contiene l'indice del drone al quale il punto (x, y)
			-- è più vicino
   			j = -1
			-- Itero su tutte le posizioni dei droni
			-- e dipingo il punto (x, y) in base al colore del drone
			-- più vicino
	   		for i = 1, num_cells do
	   			d = hypot(drone_pos_x[i] - x, drone_pos_y[i] - y)
	   			if d < dmin then
	   	 	    		dmin = d
	   				j = i
	   			end
			end
	   		love.graphics.setColor({partition_color_red[j], partition_color_green[j], partition_color_blue[j]})
	   		love.graphics.points(x, y)
	   	end
	end

	love.graphics.setColor({255, 255, 255})

	for b = 1, num_cells do
		love.graphics.circle("fill", drone_pos_x[b], drone_pos_y[b], 2)
	end

	love.graphics.setCanvas()
	io.write("fatto!\n")
	return canvas
end

function love.draw()
	love.graphics.setColor({255, 255, 255})
	love.graphics.draw(voronoiDiagram)

	love.graphics.setColor({0, 0, 0})
	love.graphics.print("SPAZIO: rigenera diagramma\nESC: esci", 1, 1)
	love.graphics.setColor({200, 200, 0})
	love.graphics.print("SPAZIO: rigenera diagramma\nESC: esci")
end

function love.keyreleased(key)
	if key == 'space' then
		voronoiDiagram = generate_Voronoi(love.graphics.getWidth(), love.graphics.getHeight(), number_cells)
	elseif key == 'escape' then
		love.event.quit()
	end
end
