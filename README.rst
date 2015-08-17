***********************************
Salish Sea MEOPAR Storm Surge Paper
***********************************
:Licenses: N/A

This is a private repo for development of the 1st storm surge paper from UBC Salish Sea MEOPAR project group.

Some or all of the files in this repo will be made public upon publication of the paper to facilitate reproducibility of the paper's results.

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
* NEMO-forcing - https://bitbucket.org/salishsea/nemo-forcing
* Generation of SSH anomaly forcing files 
    - Tofino - http://nbviewer.ipython.org/urls/bitbucket.org/salishsea/tools/raw/tip/I_ForcingFiles/OBC/SSH_Tofino.ipynb
    - Port Hardy - http://nbviewer.ipython.org/urls/bitbucket.org/salishsea/tools/raw/tip/I_ForcingFiles/OBC/SSH_PortHardy.ipynb

For more information about the Salish Sea modelling project, please visit http://salishsea-meopar-docs.readthedocs.org/en/latest/

Recent model results can be found here: http://salishsea.eos.ubc.ca/nemo/index.html


