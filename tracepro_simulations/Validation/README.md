# Folder Structure
* **Export_BRDF** - contains different exported brdf-files as .txt
* **irradiance_maps** - contains irradiance maps for exported brdf-files

## Validation Process

The validation process was as follows:

First of all a brdf-file was generated as an export with specified scattering behavior. This was imported as .txt file in the TracePro Surface Property Editor. Then the exported surface was applied to the sample in the BSDF_Projekt.OML simulation. The scattering behavior was then checked using the irradiance map on the detector screen to determine whether it corresponds to the generated/ expected scattering behavior.

**Note** Picture Validation_45_deg.png shows the validation procsess. The sample was irradiated at an angle of 45 degrees.
