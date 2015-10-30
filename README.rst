***********************************
Salish Sea MEOPAR Storm Surge Paper
***********************************
:License: Apache License, Version 2.0:Licenses: N/A

This is a repository for development of the 1st storm surge paper from UBC Salish Sea MEOPAR project group.

This repository has been made public to facilitate reproducibility of the paper's results.


Licenses
========

The Salish Sea NEMO analysis and documentation are copyright 2013-2015 by the `S
alish Sea MEOPAR Project Contributors`_ and The University of British Columbia.

They are licensed under the Apache License, Version 2.0.
http://www.apache.org/licenses/LICENSE-2.0
Please see the LICENSE file for details of the license.

The copyright of the manuscript files is held by Taylor and Francis. The manuscript can be cited as:

Soontiens, N., Allen, S., Latornell, D., Le Souef, K., Machuca, I., Paquin, J.-P., Lu, Y., Thompson, K., Korabel, V. (2015). Storm surges in the Strait of Georgia simulated with a regional model. Submitted to Atmosphere-Ocean. doi:10.1080/07055900.2015.1108899


.. _Salish Sea MEOPAR Project Contributors: https://bitbucket.org/salishsea/docs



Organization of files
**********************

The files are organized into several folders:

* AO_guides - manuscript tex and pdf files, templates, and AO style files
* comments - comments from co-authors before first submission
* FigureScripts - notebooks and other files needed to generate figures. Includes text files with storm surge statistics. 
* Revisions - files used to guide the revisions process, including modified analysis files and extra analysis notebooks

  - tides - files used to produce new tidal predictions

    + analysis - tidal predictions for analysis
    + forcing - tidal predictions for forcing
* RoughWork - rough drafts and figures
* run_files - namelists and yaml files used to produce simulations

Some additional files are described here:

* contributions.txt - description of contributions from each author
* refrees.txt - list of suggested referees
* stormtools_revisions.py - module with analysis tools and functions 

Dependencies
************

Some of the analysis and simulations depends on code and files written in separate packages. These packages include

* SalishSeaTools - http://salishsea-meopar-tools.readthedocs.org/en/latest/SalishSeaTools/salishsea-tools.html#salishseatools
* Generation of SSH anomaly forcing files 
    - Tofino - http://nbviewer.ipython.org/urls/bitbucket.org/salishsea/tools/raw/tip/I_ForcingFiles/OBC/SSH_Tofino.ipynb
    - Port Hardy - http://nbviewer.ipython.org/urls/bitbucket.org/salishsea/tools/raw/tip/I_ForcingFiles/OBC/SSH_PortHardy.ipynb
* NEMO code 3.4
    - The simulations were generated with version 3.4 of the NEMO ocean model. More details are found here: http://www.nemo-ocean.eu/
* For more information about the Salish Sea modelling project, please visit http://salishsea-meopar-docs.readthedocs.org/en/latest/
* Recent model results can be found here: http://salishsea.eos.ubc.ca/nemo/index.html


