irradiance_map_cartesian = zeros(256, 256, 19) //x,y,s
irradiance_map_spherical = zeros(360, 90, 19) //a,e,s

/*Parse Irradiance Maps*/
for s = 0:18
    path = "io/irradiance_maps/100k_Rays/" + string(s*5) + "_deg.txt"
    lines = mgetl(path)
    for x = 29:284
        line = lines(x)
        values = tokens(line)
        irradiance_map_cartesian(x-28,:,s+1) = strtod(values)
    end
end

/*Transform into half-spere shell coordinate system*/
for a = 1:360
    for e = 1:90
        for s = 1:19
            r = 128 * tand((90-e)/2)
            x = round(r*cosd(a))+128
            y = round(r*sind(a))+128
            
            irradiance_map_spherical(a,e,s) = irradiance_map_cartesian(x, y, s)
        end
    end
end
