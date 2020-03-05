spectral_irradiance_map_spherical = zeros(35, 35, 2, 1044) //target azimuth s, detector azimuth e , wavelength/count indicator, wavelength/count data

lines = mgetl("io/goniometer_meas.txt")
for i = 1:4356
    line = lines(i)
    values = tokens(line)
    select modulo(i,4),
    case 1 then //header
        source_elevation = (strtod(values(1)) + 90) / 5
        target_elevation = (strtod(values(2)) + 90) / 5,
    case 2 then //count data
        spectral_irradiance_map_spherical(source_elevation,target_elevation,2,:) = strtod(values),
    case 3 then //wavelength data
        values = strsubst(values, ",", ".")
        spectral_irradiance_map_spherical(source_elevation,target_elevation,1,:) = strtod(values),        
    end
end

irradiance_map_spherical = spectral_irradiance_map_spherical(:,:,2,381) //counts at 550.18969 nm
irradiance_map_theta = zeros(16,16) //theta 5:5:80, theta_zero 5:5:80

for target_azimuth = -80:5:80
    for detector_azimuth = -80:5:80
        theta = target_azimuth - detector_azimuth
        theta_zero = target_azimuth
        if((theta >= 5 & theta <= 80) & (abs(theta_zero) >= 5 & abs(theta_zero) <= 80))
            if irradiance_map_theta(theta/5, abs(theta_zero)/5) == 0
                irradiance_map_theta(theta/5, abs(theta_zero)/5) = irradiance_map_spherical((target_azimuth + 90) / 5, (detector_azimuth + 90) / 5)
            else
                irradiance_map_theta(theta/5, abs(theta_zero)/5) = (irradiance_map_spherical((target_azimuth + 90) / 5, (detector_azimuth + 90) / 5) + irradiance_map_theta(theta/5, abs(theta_zero)/5)) / 2
            end
        end
    end
end