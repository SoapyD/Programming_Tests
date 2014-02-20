
local quads = {};


--A TEST FOR THE ABILITY OF THE QUAD CHECKER TO FIND SPECIFIC VALUES FROM A COMPLETE LIST
function Test_quad_method()

    for i = 1, 15000 do
	    id = table.getn(quads)+1
	    quads[id] = "card" .. i
    end
    print("Quad_size: " .. table.getn(quads))

    local return_info = {}

	return_info = Quad_Check("card2428")
end

--A TEST FOR THE METHOD THAT ALLOWS FOR THE CREATION IF A QUAD LIST
--RANDOM CARDS ARE GENERATED AND PROCEDURALLY ADDED TO THE QUAD LIST THEN PRINTED TO SHOW THE RESULTS
function Test_quad_list()

    for i = 1, 300 do
	    local card_name = math.random(6000) --"card" .. math.random(300)
	    Quad_Add(card_name)
	end

    for i = 1, table.getn(quads) do
    	print("card name#" .. i .. " " .. quads[i] )
    end

end

function Quad_Add(search_value)

	if ( table.getn(quads) == 0 ) then
	   	quads[1] = search_value
	    --print("val " .. search_value .. " start")
	else
	    local value_added = false

		if (search_value > quads[table.getn(quads)]) then --add the card if it's larger than the list end
			quads[table.getn(quads) + 1] = search_value
			value_added = true
			--print("val " .. search_value .. " added to end")
		end
		if (search_value < quads[1]) then --add the card if it's larger than the list end
			table.insert(quads, 1, search_value)
			value_added = true
			--print("val " .. search_value .. " inserted onto start")
		end

		if ( value_added == false) then
		    local return_info = {}
			return_info = Quad_Check(search_value)
			--found_bool = true, found_quad = no quad found
			if (return_info[1] == true and return_info[2] == -1) then
				table.insert(quads, return_info[5] + 1, search_value)
				--print("val " .. search_value .. " sorted")
				--print("current " .. quads[return_info[5]] .. "|| next " .. quads[return_info[5]+1])
			end
		end
	end
end


function Quad_Check(search_val)

local return_info = {}

	local min_height = -1
	local max_height = -1
	local found_quad = -1
	local found_bool = false
	local pos_before = -1

    local run_loop = true
    local count = 0
    list_length = table.getn(quads)
    min_height = 1
    max_height = list_length

    local band_1 = -1
    local band_2 = -1
    local band_3 = -1
    local band_4 = -1             
    local saved_min = -1
    local saved_max = -1 

    while run_loop == true do

    	--SET THE VALUES OF THE BAND NUMBERS, NOT WHATS BEING CHECKED AGAINST
    	local band_size = math.round((max_height - min_height) / 4)
    	band_1 = min_height
    	band_2 = (band_size * 2) + min_height
    	if( band_2 > max_height) then
    		band_2 = max_height
    	end
    	band_3 = (band_size * 3) + min_height
    	if( band_3 > max_height) then
    		band_3 = max_height
    	end    	
    	band_4 = max_height

    	--print("band_size: " .. band_size)
    	--print("band#1: " .. band_1 .. " || value: " .. quads[band_1])
    	--print("band#2: " .. band_2 .. " || value: " .. quads[band_2])
    	--print("band#3: " .. band_3 .. " || value: " .. quads[band_3])
    	--print("band#4: " .. band_4 .. " || value: " .. quads[band_4])    	    	    	
    	--print("--------------------------------------------") 

    	--EXACT VALUE CHECKS
    	if (search_val == quads[band_1]) then
    		found_quad = band_1
    	end 
    	if (search_val == quads[band_2]) then
    		found_quad = band_2
    	end 
    	if (search_val == quads[band_3]) then
    		found_quad = band_3
    	end 
     	if (search_val == quads[band_4]) then
    		found_quad = band_4
    	end    	    	

    	--BETWEEN-THE-BANDS CHECK
    	if (search_val > quads[band_1] and search_val < quads[band_2]) then
    		min_height = band_1
    		max_height = band_2
    	end
    	if (search_val > quads[band_2] and search_val < quads[band_3]) then
    		min_height = band_2
    		max_height = band_3
    	end
    	if (search_val > quads[band_3] and search_val < quads[band_4]) then
    		min_height = band_3
    		max_height = band_4
    	end	


    	--if search val is lower than band1
    	--if search val is higher than band4    	

    	if ( found_quad ~= -1) then
    		--print("quad found: " .. found_quad .. " in " .. count .. " passes")
    		run_loop = false
    		found_bool = true
    	end

    	if ( found_quad == -1) then
	    	if (saved_min == min_height and saved_max == max_height) then
	    		--print("quads exhausted:")
	    		--print("between: " .. min_height .. " and " .. max_height  .. " in " .. count .. " passes")
	    		for i = min_height, max_height do
	    			if (search_val == quads[i]) then
	    				found_quad = i
	    			end
	    			if (search_val > quads[i]) then
	    				pos_before = i
	    			end	    			
	    		end
	    		--print("found_quad:" .. found_quad)
	    		--print("pos_before:" .. pos_before)
	    		run_loop = false
	    		found_bool = true
	    	end
    	end

    	saved_min = min_height
    	saved_max = max_height

    	if (count >= 500) then
    		run_loop = false
    	end

    	if ( run_loop == false) then
    		return_info[1] = found_bool
    		return_info[2] = found_quad
    		return_info[3] = min_height
    		return_info[4] = max_height 
    		return_info[5] = pos_before    		
    	end

    	count = count + 1
    end

    return return_info

end


--Test_quad_method()
Test_quad_list()