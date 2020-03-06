# Folder Structure
* **assets** - assets i.e. configuration/header templates for all scripts
* **io** - input/output directory for all scripts
* **legacy_files** - old partial python implementation of the functions realised in scilab, with known bugs and only provided for reference

## Goniometer Measurement Parser
**Requires** Goniometer Measurement file containing full spectrum data and target azimuth/and detector azimuth in every permutation for angles from 5° to 80° in 5° increments at the location `io/goniometer_meas.txt`

**Returns** 2D matrix `irradiance_map_theta(16,16)` as a variable in the scilab workspace after execution which contains unnormalized brdf data at ~550 nm for 1D theta and theta_zero values from 5° to 80° in 5° increments. Call as `irradiance_map_theta(theta/5,theta_zero/0)`. Refer to the documentation folder for functional documentation.

## Irradiance Maps Parser
**Requires** Irradiance Maps from 0° to 90° incidence_elevation in 5° increments generated using the file located under tracepro_scripts at the location `io/irradiance_maps/*specify*`

**Returns** 3D matrix `irradiance_map_spherical(360, 90, 19)` as a variable in the scilab workspace after execution containing unnormalized brdf data in a half-sphere shell indexed by azimuth (0°-360° in 1° incerements) and elevation (0°-90° in 1° increments) for each incidence_elevation. Call as `irradiance_map_spherical(azimuth, elevation, incidence_elevation/5)`. Refer to the documentation folder for functional documentation.

## Surface Property Composer
**Requires** Config files located at `assets/surface_property_composer/header_template.cfg` and `assets/surface_property_composer/table_bsdf_data_template.cfg`. brdf data as the script configuration demands; `irradiance_map_theta(16,16)` as provided by the Goniometer Measurement Parser in the submitted configuration

**Returns** TracePro compatible Surface Property which is located at `io/exported.brdf.txt` after execution. Refer to the documentation folder for functional documentation.
