import numpy as np
import pandas as pd

o = open('output.brdf.txt', 'w')
h = open('header_template.cfg', 'r')
o.write(h.read())
o.write('\t\ttest')
o.close()

header = ['Temperature',
	      'Wavelength',
	      'IncAngle',
	      'AziAngle',
	      'Abso_S',
	      'Abso_P',
	      'Refl_S',
	      'Refl_P',
	      'Tran_S',
	      'Tran_P',
	      'PhaseRefl',
	      'PhaseTran',
	      'BRDF_A',
	      'BRDF_B',
	      'BRDF_By',
	      'BRDF_g',
	      'BRDF_gy',
	      'BTDF_A',
	      'BTDF_B',
	      'BTDF_By',
	      'BTDF_g',
	      'BTDF_gy']

df = pd.DataFrame(columns=header)
rs = df.append([42,69,73], ignore_index=True)
#df.append(pd.Series(), ignore_index=True)
# + ['0'] * 16
print(rs)
