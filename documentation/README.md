# Documentation
The purpose of this functional documentation is to give the reader an overview on how this project came to be the way it is presented and what to do with the provided scripts. Sources are mainly the TracePro documetation excerpts located in the same folder

## About the TracePro BRDF Understanding
TracePro expects brdf data to be provided in form of a Harvey-Shack BSDF Format. With this

## About the TracePro Surface Property File
TracePro Surface Property files can be used to decribe all sort of surface properties, not only scattering ones. Surfaces in TracePro can be described through those files, which have distinctive structure, which is explained in the TracePro documentation. The focus here is to name the most important bits of the format for brdf definition.

A surface property definition file mainly consists of three parts, a header, a surface data columns section, and a bsdf data colums section.

The Header defines general aspects of the surface. For our purposes, the following flags are usually important

Flag | Value | Description
--- | --- | ---
Coating | 1 | *tabular data* seems to specify whether the surface data colums are used or not, further documentation needed to determine exact function
Scatter | 5 | *Asymmetric Table* specifies the use of the bsdf data colums section rather than for example the ABg-scatter model provided in the data columns section. As no Asymmetrical model is used, it is unclear why 4 - *Table* or 8 - *Use BSDF Properties* are not used instead*
Polarization | 0 | no ploarization, same values for S and P terms
Solve | BRDF | Solve for BRDF

The surface data columns section provides general surface properties for different incidence angles in elevational and azimuthal directions. As we are only focusing on surface wich scatter independent from azimuthal incidance, usually a single azimuthal angle (i.e 0 or 180) is provided for each incidence_elevation. The values indexed by these keys are absorptance, reflectance and coefficients for the ABg-BRDF model, which are not used and set as null. As an example, to get a perfect mirror, one could set all absortance values and ABg coefficients to 0 and relflectance values to 1. Temperature and Wavelegth are provided as well (this is true also for bsdf data colums, but can reamin constant as far as we are concerned).

The brdf data colums feature the same keys as the surface data columns described above, but different values. For every incidence angle, a complete set of numerical scattering information is provided in the form of brdf and (not used by us) btdf values in the form of ScatterBeta and ScatterAzimuth values as per the Harvey-Shack BSDF model described above.

## A Note on Energy Conversation and Quantitative Measurements


## First Idea - Generating BRDF Data from BRDF Data

## Validation of BRDF Composer using simulated Data

## Tales of Getting Scattering Goniometer data in the right format

## Further down the Road
