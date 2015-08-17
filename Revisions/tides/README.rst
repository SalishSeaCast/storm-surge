Tide MATLAB Scripts
*******************

The MATLAB scripts in this directory were used to generate tidal predictions for model forcing and model analysis.
The predictions are calculated in the following manner:

1. A water level time series is filtered to remove large non-tidal events.
2. A harmonic analysis is applied to the filtered time series using t_tide (http://www.eos.ubc.ca/~rich/#T_Tide)
3. Tidal predictions are generated from the constituents solved in the harmonic analysis.
Three predictions are generated:
    a. A prediction with all constituents that have signal to noise ratio greater than 2 and excluding long period constituents like Sa, Ssa, Mf, Ms, etc (pred_all).
    b. A prediction like above but with shallow water constituents excluded (pred_noshallow).
    c. A prediction with only the 8 large constituents :M2, S2, N2, K2, K1, O1, P1, Q1 (pred_8).


Scripts
^^^^^^^

* get_ttide_8_filter(csvfilename, location, starts, ends, type)
    - generates the tidal predictions as described above
    - csvfilename is the filename with the saved water level time series (see Input Files)
    - location is the name of the tide gauge (e.g 'Point Atkinson')
    - starts is the start date of the desired tidal prediction (eg. '01-Jan-2011')
    - ends is the end date of the desired tidal prediction ( e.g '31-Dec-2011')
    - type is a string the specifies a 'DFO' time series or 'NOAA' time series as the input file
* filter_tides(csvfilename, cut_off) and filter_tides_NOAA(csvfilename, cutoff)
   - Function that applies the Doodson tidal filter
   - csvfilename is the file that contains the water level time series
   - cut_off is the cut off amplitude for the filter
   - one script handles DFO data and the other handles NOAA data
* calculate_harmonics_filter(csvfilename, location) and calculate_harmonics_filter_NOAA(csvfilename, location)
    - Performs the harmonic analysis. Saves the harmonics and output from the analysis.
    - csvfilename is the filename of the water level time series
    - location is the location of the tide gauge (e.g 'Point Atkinson')


Input files
^^^^^^^^^^^

The input files are water level times series from DFO or NOAA.

* DFO
    - Data is from this website http://www.isdm-gdsi.gc.ca/isdm-gdsi/twl-mne/index-eng.htm
    - These file names have the format 'wlev_number_date.csv'
* NOAA
    - Data is from NOAA's National Ocean Service http://tidesandcurrents.noaa.gov/stations.html?type=Water+Levels
    - The latitude of the station has been added to the second row, second column
    - The file names have the format name_date.csv

Output files
^^^^^^^^^^^^

Three output files are generated from each analysis

1. name_analysis_filter_dates
   - output from the t_tide harmonic analysis
2. name_harmonics_dates_filter.csv
   - harmonic constituents from analyzing the filtered time series
3. name_t_tide_compare8_dates_snr2_filter.csv
   - the three tidal predictions described above

Files are organized into a forcing directory (stations outside of Salish Sea model domain) and a analysis directory (stations inside of Salish Sea model domain).

Dependencies
^^^^^^^^^^^^

These scripts make use of tidal analysis code t_tide written by Dr. Rich Pawlowicz.
The t_tide code is available here: http://www.eos.ubc.ca/~rich/#T_Tide
