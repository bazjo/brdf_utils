# Documentation
The purpose of this functional documentation is to give the reader an overview on how this project came to be the way it is presented and what to do with the provided scripts. Sources are mainly the TracePro documentation excerpts located in the same folder.

## About the TracePro BRDF Understanding
TracePro expects brdf data to be provided in form of a Harvey-Shack BSDF Format. With this format, scattering data is provided relative to the main direction of scatter, which is called the specular direction beta_zero or the angle theta_zero in case of 1D scattering. With this direction at its center, a polar coordinate system is projected onto a unit half sphere shell with the ScatterAzimuth and a scalar beta as the length between beta and beta_zero effectively being the radius with the maximum value of two as a scattering direction 180° from the specular direction. More detailed information is given in the TracePro documentation.

## About the TracePro Surface Property File
TracePro Surface Property files can be used to describe all sort of surface properties, not only scattering ones. Surfaces in TracePro can be described through those files, which have distinctive structure, which is explained in the TracePro documentation. The focus here is to name the most important bits of the format for brdf definition.

A surface property definition file mainly consists of three parts, a header, a surface data columns section, and a bsdf data colums section.

The Header defines general aspects of the surface. For our purposes, the following flags are usually important

Flag | Value | Description
--- | --- | ---
Coating | 1 | *tabular data* seems to specify whether the surface data columns are used or not, further documentation needed to determine exact function
Scatter | 5 | *Asymmetric Table* specifies the use of the bsdf data columns section rather than for example the ABg-scatter model provided in the data columns section. As no Asymmetrical model is used, it is unclear why 4 - *Table* or 8 - *Use BSDF Properties* are not used instead*
Polarization | 0 | no polarization, same values for S and P terms
Solve | BRDF | Solve for BRDF

The surface data columns section provides general surface properties for different incidence angles in elevational and azimuthal directions. As we are only focusing on surface which scatter independent from azimuthal incidence, usually a single azimuthal angle (i.e 0 or 180) is provided for each incidence_elevation. The values indexed by these keys are absorptance, reflectance and coefficients for the ABg-BRDF model, which are not used and set as null. As an example, to get a perfect mirror, one could set all absorptance values and ABg coefficients to 0 and reflectance values to 1. Temperature and Wavelength are provided as well (this is true also for bsdf data columns, but can remain constant as far as we are concerned).

The brdf data columns feature the same keys as the surface data columns described above, but different values. For every incidence angle, a complete set of numerical scattering information is provided in the form of brdf and (not used by us) btdf values in the form of ScatterBeta and ScatterAzimuth values as per the Harvey-Shack BSDF model described above.

## A Note on Energy Conservation and Quantitative Measurements
The incident light is divided into three parts. One is absorbed by the target, and is stated in the Abso_P and Abso_S fields of the Data Columns.  One is reflected in the specular direction and is stated in the Refl_P and Refl_S also in the data columns. The third one is the Total Scatter which is the total amount of light which is scattered according to the brdf. Those parts must add up to one to fulfill the law of energy conservation.

For the measured data, this rises a significant problem. First of all, no values for the Absorptance and Reflectance are known. Second, the bsdf data is only provided in spectral "counts" with no real radiometric unit. If this had been the case, one would have to integrate the bsdf over all scatter to get the total scatter, in this case by taking the sum over the bsdf and the corresponding solid angle for all scatter. Thankfully, TracePro can also simulate Properties which don't conserve energy properly, so for our tests, the counts where simply shrunk to an order of magnitude which seemed appropriate for scattering data. For a further analysis however, implementing conservation of energy and scaling the brdf correctly is mandatory.

## First Idea - Generating BRDF Data from BRDF Data
In the beginning, no measurements had been performed yet. To proceed with the work nevertheless, a plan was filed to generate irradiance maps capturing the scatter of a known surface in TracePro, recalculating the brdf and than comparing the generated surface property with the original one. This approach has the drawback that potential problems could lay in the process of capturing and parsing the irradiance distribution as well as the brdf calculation itself, and was thus abandoned after real measurement data was available. The Irradiance Maps Parser and associated TracePro Script are the remainders of this approach.

## Validation of BRDF Composer using simulated Data
Nevertheless, a validation of the Surface Property Composer script was necessary and was performed by the means of simulated scattering data. As the measurement data will have a uniform azimuthal distribution of scatter, no simulations with a variable azimuthal distribution were deemed necessary, however they should be considered in further development. Three test scenarios were simulated and all showed the expected result.

![brdf values all zero](https://raw.githubusercontent.com/bazjo/brdf_utils/master/tracepro_simulations/Validation/irradiance_maps/NoScatter.bmp?token=AF7CCH2EF2P25D6Z6Z5FRNS6NTPQE "brdf values all zero")
brdf values all zero

![brdf values all constant but not zero](https://raw.githubusercontent.com/bazjo/brdf_utils/master/tracepro_simulations/Validation/irradiance_maps/ScatterBetaNotConstant.bmp?token=AF7CCH67DZUYQJ3HH4MFMGK6NTQWS "brdf values all constant but not zero")
brdf values all constant but not zero

![brdf values linearly increasing with ScatterBeta](https://raw.githubusercontent.com/bazjo/brdf_utils/master/tracepro_simulations/Validation/irradiance_maps/ScatterBetaLinearIncreasing.bmp?token=AF7CCH2PU2YLMREBYJBIQQC6NTPWG "brdf values linearly increasing with ScatterBeta")
brdf values linearly increasing with ScatterBeta

To validate generated brdf data, the new surfaces must be integrated in TracePro. New surfaces are integrated via the Surface Property Generator. The data is imported in form of a .txt file. New surfaces can be selected by using the names contained in the file (line 6: "Name" & line 7: "Catalog"). These are saved directly to the TrracePro.db after the import. If the catalog has not yet been defined, TracePro automatically creates a new catalog with the appropriate name. After import, the surface can be applied directly to a sample. It should be noted here that the surfaces generated by the Scilab-scripts do not use fixed axes for the zero-azimuth for asymmetrical scattering, so the checkmark must be removed from the checkbox.


## Tales of Getting Scattering Goniometer data in the right format
The scatter goniometer data contains spectra for all combinations of target and detector azimuth, which had to be processed into the one-dimensional Harvey-Shack format. First of all the theta and theta_zero values where calculated for all combinations. Secondly, as the brdf was supposed not to depend on the ScatterAzimuth, the values for positive and negative theta were averaged for each theta_zero. Lastly, as only angles from 5° to 80° of theta could be obtained for every theta_zero, only those where output in the Surface Property file.

It has to be noted, that due to the nature of the ScatterBeta calculation, there are different values of ScatterBeta for each theta_zero which serve as keys to the brdf values in the Surface Property. TracePro can not handle this. There are three possible solutions to this problem:
* only output a single theta_zero, which is the workaround implemented at the moment
* interpolate the Scatter_Beta values onto a smaller grid common for all theta_zero values, greatly increasing the file size
* set the angles for the goniometer measurement, so that the Scatter_Beta values can be rounded to the same values for all theta_zero values

with the last option being the most promising.

## Further down the Road
Next in the agenda it should be to get implement one of the solutions mentioned above. The next important thing is to get absorptance and reflectance data and generate quantitative correct surface property data files. It could also be beneficial to validate more simulated data or to follow the path initially taken with the irradiance maps parser.
