spectral_irradiance_map_spherical = zeros(200, 200, 2, 1044) //source elevation s, target elevation e , wavelength/count indicator, wavelength/count data

lines = mgetl("io/goniometer_meas.txt")
for i = 1:4356
    line = lines(i)
    values = tokens(line)
    select modulo(i,4),
    case 1 then //header
        source_elevation = strtod(values(1)) + 90
        target_elevation = strtod(values(2)) + 90,
    case 2 then //count data
        spectral_irradiance_map_spherical(source_elevation,target_elevation,2,:) = strtod(values),
    case 3 then //wavelength data
        values = strsubst(values, ",", ".")
        spectral_irradiance_map_spherical(source_elevation,target_elevation,1,:) = strtod(values),        
    end
end
