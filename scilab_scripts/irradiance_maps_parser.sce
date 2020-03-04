irradiance_map_cartesian = zeros(256, 256, 19) //x,y,s
irradiance_map_polar = zeros(360, 90, 19) //a,e,s

for s = 0:18
    path = "io/irradiance_maps/100k_Rays/" + string(s*5) + "_deg.txt"
    lines = mgetl(path)
    for x = 29:284
        line = lines(x)
        values = tokens(line)
        irradiance_map_cartesian(x-28,:,s+1) = strtod(values)
        i = i+1
    end
end

for a = 1:360
    for e = 1:90
        for s = 1:19
            irradiance_map_polar(a,e,s) = 0
            //wrong trasformation atm. square(circle inside square) needs to be projected onto sperical half-plane "orange peel"
        end
    end
end
