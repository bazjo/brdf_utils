temperature = 300
wavelength = 0.55
source_azimuth = 0
absorbtion = 0.05

surface_property = mopen("io/exported.brdf.txt", "wt");

//Copy File Header from Config file
header = mgetl("assets/surface_property_composer/header_template.cfg")
mputl(header, surface_property)

//Generate Surface Data Columns
for incidence_angle=45//5:5:80
    mputstr(string(temperature), surface_property) //Temperature
    mputstr(ascii(9), surface_property)// \t the scilab way
    mputstr(string(wavelength), surface_property) //Wavelength
    mputstr(ascii(9), surface_property)
    mputstr(string(incidence_angle), surface_property) //IncAngle
    mputstr(ascii(9), surface_property)
    mputstr(string(source_azimuth), surface_property) //AziAngle
    mputstr(ascii(9), surface_property)
    for i=1:2
        mputstr(string(absorbtion), surface_property) //Abso_S and Abso_P
        mputstr(ascii(9), surface_property)
    end
    for i=1:16
        mputstr("0", surface_property) //zero non-needed values
        mputstr(ascii(9), surface_property)
    end
    mputl("", surface_property)// \n the scilab way
end

//Generate Table BSDF Data
header = mgetl("assets/surface_property_composer/table_bsdf_data_template.cfg")
mputl(header, surface_property)

for incidence_angle=45//5:5:80
    for theta=5:5:80//scatter_beta=0:0.034689402098049:0.9//theta=5:5:80//scatter_beta=0:0.05:2
        for scatter_azimuth=0:10:350
            mputstr(string(temperature), surface_property) //Temperature
            mputstr(ascii(9), surface_property)// \t the scilab way
            mputstr(string(wavelength), surface_property) //Wavelength
            mputstr(ascii(9), surface_property)
            mputstr(string(incidence_angle), surface_property) //IncAngle
            mputstr(ascii(9), surface_property)
            mputstr(string(source_azimuth), surface_property) //AziAngle
            mputstr(ascii(9), surface_property)
            mputstr(string(abs(sind(theta)-sind(incidence_angle))), surface_property) //ScatterBeta
            //mputstr(string(scatter_beta), surface_property) //ScatterBeta
            mputstr(ascii(9), surface_property)
            mputstr(string(scatter_azimuth), surface_property) //ScatterAzimuth
            mputstr(ascii(9), surface_property)
            //mputstr(string(0.120387), surface_property) //BRDF
            mputstr(string(irradiance_map_theta(theta/5,incidence_angle/5)/1000000), surface_property) //BRDF
            mputstr(ascii(9), surface_property)
            mputstr("0", surface_property) //BTDF
            mputstr(ascii(9), surface_property)
            mputl("", surface_property)// \n the scilab way
        end
    end
end
        
mclose(surface_property);
