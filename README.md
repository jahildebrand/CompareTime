# CompareTime
CompareTime compares the time of arrival of a signal at an array of stations to construct a Time-Difference-of-Arrival matrix.
Use this code in the sequence: RainbowClick -> RealignWaterfall -> CompareTime.
Airguns have been detected on an array of sensors and separated into shots from individual ships (RainbowClick) and then time aligned (RealignWaterfallPlots - create record section in the parlance of seismology). Now the arrivals from each receiver must be compared and turned into a Time-Difference-of-Arrival matrix.
1)	Begin by creating an output directory in the format: YEARMNDY with subdirectory HR.
2)	After running CompareTime plots appear that show the inter-shot interval for each ship. These plots overlay the sequence observed at each receiver station.  The inter-shot interval must be consistent to within a small fraction of a sec, and so any outlier points are most likely errors in picking the arrival at that station.
3)	The next set of plots show the TDOA for each pair of receivers.  For N receivers there will be: (N-1)/2 * N pairs.
4)	Outlier points are fixed using the MATLAB function filloutliers, and the number of points corrected is listed for each ship. TF is the location for the filled outliers (o = original, 1 = corrected)
5)	The output is saved as an mTDOA (matrix of TDOA values) file by ship with name mtdoa_YEARMNDY_HRMNSCs# where s# is the ship number. Columns are numbers of array 1,2,3,4,5 % order of TDOA columns % 2-1 3-1 4-1 5-1 3-2 4-2 5-2 4-3 5-3 5-4 
Also within that file is mTime which is the time pick for events at site =1; and TF for the filled outliers.
