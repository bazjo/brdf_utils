import numpy as np

#s: source elevation; x,y: target iluminance (cartesian); a: target illumination azimuth; e: target illumination elevation
irradiance_map_cartesian = [[[0 for s in range(19)] for y in range(256)] for x in range(256)]
irradiance_map_polar = [[[0 for s in range(19)] for e in range(90)] for a in range(360)]

for s in range(19):
    file_name = 'input/' + str(s * 5) + '_deg.txt'
    #print(file_name)

    with open(file_name) as input:
        input_string = input.read()
        input_line = input_string.split('\n')

        #data begins in line 28
        for x in range(28, len(input_line) - 1):
            input_value = input_line[x].split('\t')
            for y in range(len(input_value) - 1):
                irradiance_map_cartesian[x - 28][y][s] = float(input_value[y])

#print(irradiance_map_cartesian)

for s in range(19):
    for a in range(360):
        for e in range(90):
            irradiance_map_polar[a][e][s] = irradiance_map_cartesian[int(e * np.cos(a))][int(e * np.sin(a))][s]

#print(irradiance_map_polar)
