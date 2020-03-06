import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm

#s: source elevation; x,y: target iluminance (cartesian); a: target illumination azimuth; e: target illumination elevation
spectrum = [[[[0 for datapoint in range(1044)] for  type in range(2)] for scatter_angel in range(200)] for incidence_angel in range(200)]

#1045 Data Points
#1089 Measurements
#-80 -75 1880 <> Beleuchtungswinkel Streuwinkel Integrationszeit

file_name = 'input_goniometer.txt'
#print(file_name)

with open(file_name) as input:
    input_string = input.read()
    input_line = input_string.split('\n')

    for line in range(0, len(input_line) - 1):
        measurement = int(line/4)
        input_value = input_line[line].split(' ')
        cur_spectrum = [[0 for datapoint in range(1044)] for  type in range(2)]
        if line%4 == 0: #Header
            for point in range(0, len(input_value)):
                incidence_angel = int(input_value[0])
                scatter_angel = int(input_value[1])
                #print(input_value)
        elif line%4 == 1: #Counts
            for point in range(1, len(input_value)-1):
                    cur_spectrum[0][point] = float(input_value[point])
        elif line%4 == 2: #Wavelength
            for point in range(1, len(input_value)-1):
                    cur_spectrum[0][point] = float(input_value[point].replace(',', '.'))
        spectrum[incidence_angel][scatter_angel]=cur_spectrum
print(spectrum[-80][-80])
#plt.plot(spectrum[-10][40][1],spectrum[-10][40][0])
#plt.show()
