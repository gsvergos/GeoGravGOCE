# GeoGravGOCE
GeoGravGOCE Matlab GUI for processing GOCE SGG data

===================================================================================================
					GeoGravGOCE 
===================================================================================================
GeoGracGOCE app is a MATLAB®-based Graphical User Interface for:
(1) Pre-processing of the GOCE Satellite Gravity Gradients (GGs).
(2) Transformation of Global Geopotential Model's GGs from LNOF to GRF.
(3) Filtering of the GGs with: Finite Impulse Response (FIR) filter,
    Infinite Impulse Response (IIR) filter and Wavelet Multi-Resolution Analysis (WL-MRA).
(4) Transformations of the GGs from GRF to LNOF and LNOF to GRF.
---------------------------------------------------------------------------------------------------
Version: 1.0.0
Developed by GravLab Team, AUTh, 12.2021
Contact: vergos@topo.auth.gr



===================================================================================================
					USER MANUAL 
===================================================================================================
// This is a user manual for working with the GUI of the GeoGravGOCE software.




******************************************  Installation ******************************************

// Open Matlab.
// Locate in your local directory the app installation file which is characterized by the suffix
 '.mlappinstall'.
// Double-click on GeoGravGOCE.mlappinstall. 
// A dialog box is opened. Click install.
// Once installed, the app is added to the MATLAB Toolstrip named 'APPS'.
// In the 'APPS' find the GeoGravGOCE icon to run the program.

// The GeoGravGOCE GUI is visually divided into the four tabs:
// (1) SGG Pre processing 
// (2) GGM transformation: LNOF to GRF
// (3) Filtering ---> [FIR, IIR, Wavelet]
// (4) RSs Transformations (RSs= Reference Systems)
// The functionality of tabs is described in the following sections:




************************************** (1) SGG Pre-processing **************************************
▪In SGG panel:
	▪Load the Level_2 GOCE data (after parsing*):
------- EGG_NOM_2 pushbutton: load the EGG_NOM_2 gravity gradients in GRF, in ASCII format.
------- SST_PSO_2 pushbutton: load the SST_PSO_2 precise science orbits, in ASCII format. 
	// *Note: The "GOCEPARSER" tool, provided by ESA, is capable of transforming
    	// the Earth Explorers File (EEF) format into other common formats (e.g: .sgg, .kin, .qat).
	// Optional: You can download the GOCEPARSER Parser from here: 
    	// https://earth.esa.int/eogateway/tools/goceparser
------- Calculate SGG pushbutton: Processing the loaded data.
     	After a successful calculation, you automatically take the "SGG_GRF.mat" and
	"SGG_GRF_Report.txt" outputs and the below pushbuttons are enabled.
	--------------------------------------------------------------------------------------------
	▪Export the processed data:
------- Statistics Vij(.mat) & Report(.txt) pushbutton: calculates the processed
	files' statistics with a corresponding report, including the necessary information.
------- Gravity Gradients pushbutton: creates figures with the Vij in the GRF, in time domain.
------- GOCE Orbit Track pushbutton: creates global maps with the GOCE orbit track.
     	// Note: The maps are created via the "M_Map" mapping toolbox, with the condition that the
	// M-file exists in the user's path.
     	// Optional: You can download the M_Map toolbox from here: 
    	// https://www.eoas.ubc.ca/~rich/map.html
------- GOCE Altitude pushbutton: creates figures with the GOCE altitude.
----------------------------------------------------------------------------------------------------
▪In GrafLab panel:
------- Create Input Format (lat,lon,h) pushbutton: creates a TXT-file with the
	GGs' geodetic coordinates in the format: (latitude, longitude, height).
	(the latitude and the longitude in degrees and the ellipsoid height in meters).

------- RUN GrafLab pushbutton: computes the gravitational tensor components 
	(Vxx,Vyy,Vzz,Vxy,Vxz,Vyz) in the LNOF via "GrafLab" software for the already processed
	data or other external multiple input files.	
	When you click the pushbutton:
	(1) in the first open file selection dialog box, select the GGM file (.gfc). 
	(2) in the second dialog box, enter the required parameters for the GrafLab software.
	(3) in the third open file selection dialog box, select the .TXT file with geodetic
	coordinates in the following format: latitude (degrees), longitude (degrees), 
	ellipsoid height (meters). (The output of previous pushbutton is matching here.)
	
	// Note: The calculation is executed with the condition that the graflab M-file 
    	// exists in the user's path.
    	// Optional: You can download the GrafLab software from here: 
	// http://www.svf.stuba.sk/en/departments/department-of-theoretical-geodesy/science-and-research/downloads.html?page_id=4996
	// Graflab References: 
	// Bucha, B., Janak, J., 2013. A MATLAB-based graphical user interface
	// program for computing functionals of the geopotential up to ultra-high 
	// degrees and orders. Computers and Geosciences 56, 186-196,
	// http://dx.doi.org/10.1016/j.cageo.2013.03.012.
----------------------------------------------------------------------------------------------------
▪In Display panel:
------- The gravity gradients Vzz and Vyy (Eötvös) and the GOCE altitude (meters) are presented.	 




******************************* (2) GGM transformation: LNOF to GRF *******************************

▪In Load Data for Tranformation panel:
------- GGM file pushbutton:load the GGM gravity gradients in LNOF, in ASCII format(Graflab output
	as extracted in first tab - latitude, longitude, altitude, Vxx, Vyy, Vzz, Vxy, Vxz, Vyz).
------- Quaternions (PSO_2_QAT) pushbutton:load the SST_PSO_2 (.qat) quaternions, in ASCII format. 
------- Transform LNOF to GRF pushbutton:Processing the loaded data.
     	After a successful calculation, you automatically take the "GGM_LNOF_2_GRF.mat" and
	"GGM_LNOF_2_GRF_Report.txt" outputs and the below pushbuttons are enabled.
----------------------------------------------------------------------------------------------------
▪In Export transformed data in GRF panel:
------- Statistics GGM Vij in GRF(.mat) & Report pushbutton:calculates the processed
	files' statistics with a corresponding report, including the necessary information.
------- Figures of Vij in GRF pushbutton:creates figures with the transformed GGM's Vij in GRF, 
	in time domain.
----------------------------------------------------------------------------------------------------
▪In Display panel:
------- The Vzz gravity gradient(Eötvös) in LNOF, EFRF, IRF and GRF is presented.	 




****************************************** (3) Filtering ******************************************
▪In Load Reduced Data panel:
 Three options are given:

(1)---- Reduced Data pushbutton: load your reduced data (= SGG-GGM) in the following required format:
       	1st cell = reduced Vxx in GRF (Eötvös)
       	2nd cell = reduced Vyy in GRF (Eötvös)
       	3th cell = reduced Vzz in GRF (Eötvös)         
 	4th cell = reduced Vxy in GRF (Eötvös)       
       	5th cell = reduced Vxz in GRF (Eötvös)         
       	6th cell = reduced Vyz in GRF (Eötvös)         
       	7th cell = longtitude in degrees (needed for figures)         
       	8th cell = latitude in degrees (needed for figures)         
       	9th cell = altitude in meters (needed for figures)           
       	10th cell = GPS time (needed  for figures)          
       	11th cell = the names of the processed files (needed for figures)
       	// Note: The needed information exists in the SGG_GRF.mat

(2)---- [SGG_GRF] & [GGM_LNOF_2_GRF] pushbutton*: load the outputs of the first and second GUI's tabs
	SGG_GRF.mat and GGM_LNOF_2_GRF.mat 

(3)---- [SGG_GRF] & [GGM gravitational tensor] pushbutton*: load the output of the first tab 
	(SGG_GRF.mat) and the computed GGM gravitational tensor components in GRF, 
	in the following required format:
	1st cell = Vxx in GRF (Eötvös)
	2nd cell = Vyy in GRF (Eötvös)
	3th cell = Vzz in GRF (Eötvös)
	4th cell = Vxy in GRF (Eötvös)
	5th cell = Vxz in GRF (Eötvös)
	6th cell = Vyz in GRF (Eötvös)

	// *Note that before the filtering, the GGM contribution is removed from the initial GOCE
	// GGs in the GRF. 
	// For the Vyz component, its average value after the reduction is also subtracted
	// due to the lower initial accuracy.
----------------------------------------------------------------------------------------------------
▪In Select Filtering Method panel:
 
	▪ FIR pushbutton: In the dialog box, input the N- filter order.
	// The Finite Impulse Response filter is designed as a bandpass filter with
 	// a Hamming window function.
	// N-order of filter = 1500 is recommended.

------- Filtered Reduced SGG pushbutton: creates figures with the filtered Vij in the GRF, 
	in time domain.
------- PSD pushbutton: creates figures with the Power Spectral Densities (PSDs) of filtered and
	unfiltered reduced GOCE signal. (unit: Eötvös/sqrt(HZ))
------- Statistics SGG pushbutton: calculates the processed files' statistics with a corresponding
	report, including the necessary information. 
------- Magnitude Response pushbutton: displays user's N-order filter's Magnitude response via
	Matlab's interactive Filter Visualization Tool.

	--------------------------------------------------------------------------------------------
	▪ IIR pushbutton: In the dialog box, input the N- filter order.
	// The Infinite Impulse Response filter is designed as bandpass filter based on 
	// the equivalent Butterworth filter.
	// N-order of filter = 3 is recommended.

------- Filtered Reduced SGG pushbutton: creates figures with the filtered Vij in the GRF,
	in time domain.
------- PSD pushbutton: creates figures with the Power Spectral Densities (PSDs) of filtered and
	unfiltered reduced GOCE signal. (unit: Eötvös/sqrt(HZ))
------- Statistics SGG pushbutton: calculates the processed files' statistics with a corresponding
	report, including the necessary information. 
------- Magnitude Response pushbutton: displays user's N-order filter's Magnitude response via
	Matlab's interactive Filter Visualization Tool.

	--------------------------------------------------------------------------------------------
	▪ Wavelet pushbutton: [Wavelet Multi-Resolution Analysis]
	In WL MRA decomposition & reconstruction panel:
------- WL MRA decomposition pushbutton: The reduced data are firstly extracted to orbits,
	and then WL-MRA is applied (db10) at 12 levels of decomposition. Furthermore, the
	figures of the detail and approximation coefficients for the 1st orbit of the Vzz gradient
	of the loaded files are created as well as their PSDs. For the original loaded files
	the Vzz gradient of the 1st orbit as well as its PSD are presented in the Display panel.   
	// *Note that the datafiles require to be continuous in time for the orbits to be extacted
	correctly and for WL-MRA to be properly applied.
------- WL MRA reconstruction pushbutton: Selective reconstruction is applied to the reduced data
	using selected coefficients.The reconstructed signal of the Vzz gradient of the 1st orbit
	as well as its PSD are presented in the Display panel, along with the original ones.   
	// Before the WL MRA reconstruction pushbutton is selected, the coefficients for 
	reconstruction must be chosen by checking the corresponding check buttons in the
	WL MRA decomposition & reconstruction panel. By default all the check buttons
	are being pre-checked, meaning that the user has to de-select or re-select the coefficients
	needed for the reconstruction.
	// A reconstruction using the detail coefficients of levels 4-7 is recommended.
	//After a successful calculation, you automatically take the "GG_WL.mat" and
	"GG_WL_Report.txt" outputs and the below pushbuttons are enabled.
------- Statistics GG WL(.mat) & Report (.txt) pushbutton:calculates the processed
	files' statistics with a corresponding report, including the necessary information. 
------- GGs after WL MRA pushbutton:creates figures with the filtered gravity gradients in GRF,	
	in time domain(daily format).
------- PSDs of GGs after WL MRA pushbutton:creates figures with the Power Spectral Densities
	(PSDs) of filtered and unfiltered reduced GOCE signal (in the original daily format).
	(unit: Eötvös/sqrt(HZ))

	--------------------------------------------------------------------------------------------
	// Note that the filtering processes are performed separately for each tensor component
	// in the GRF for every filtering method.
	// Also, note that in case that the second or the third option are chosen in the 
	Load Reduced Data panel, a final transformation (from GRF to LNOF) is applied in the
	filtered gravity gradients (the gravity gradients are saved both in GRF and LNOF in their
	 outputs).  
----------------------------------------------------------------------------------------------------
▪In Display panel:
------- The Power Spectral Densities (PSDs) of the original reduced unfiltered and filtered signal
	(Vzz component) are presented. 




************************************* (4) RSs Transformations *************************************

▪In Transformation GRF to LNOF panel:
------- Load data for GRF to LNOF transformation pushbutton:load the gravity gradients in GRF 
	in the following format:
	1st cell = latitude in degrees
	2nd cell = longtitude in degrees 
	3rd cell = altitude in meters 
	4th cell = UTC time
	5th cell = names of the processed files 
	6th cell = Vxx in GRF (Eötvös)         
	7th cell = Vyy in GRF (Eötvös)         
	8th cell = Vzz in GRF (Eötvös)         
	9th cell = Vxy in GRF (Eötvös)         
	10th cell = Vxz in GRF (Eötvös)         
	11th cell = Vyz in GRF (Eötvös)         
	12th cell = q1 (IRF to GRF)
	13th cell = q2 (IRF to GRF)
	14th cell = q3 (IRF to GRF)
	15th cell = q4 (IRF to GRF)
	16th cell = q1 (EFRF to IRF)
	17th cell = q2 (EFRF to IRF)
	18th cell = q3 (EFRF to IRF)
	19th cell = q4 (EFRF to IRF)

------- Transformation GRF to LNOF pushbutton:Processing of the loaded data. After a successful
	calculation, you automatically take the "VLNOF_gradients.mat" and "VLNOF_gradients_Report.txt"
	outputs and the below pushbuttons are enabled.
------- Statistics of the data in LNOF (.mat) & Report pushbutton:calculates the statistics of the
	processed files with a corresponding report, including the necessary information.
------- Figures of the data in LNOF pushbutton:creates figures with the transformed GG's in LNOF,
	in time domain.
----------------------------------------------------------------------------------------------------
▪In Transformation LNOF to GRF panel:
------- Load data for LNOF to GRF transformation pushbutton:load the GGs gravity gradients in LNOF
	in the following format:
       	1st cell = latitude in degrees
       	2nd cell = longtitude in degrees 
       	3rd cell = altitude in meters 
 	4th cell = UTC time
       	5th cell = names of the processed files 
       	6th cell = Vxx in LNOF  (Eötvös)         
	7th cell = Vyy in LNOF  (Eötvös)         
	8th cell = Vzz in LNOF  (Eötvös)         
	9th cell = Vxy in LNOF  (Eötvös)         
	10th cell = Vxz in LNOF  (Eötvös)         
	11th cell = Vyz in LNOF  (Eötvös)         
	12th cell = q1 (EFRF to IRF)
	13th cell = q2 (EFRF to IRF)
	14th cell = q3 (EFRF to IRF)
	15th cell = q4 (EFRF to IRF)
	16th cell = q1 (IRF to GRF)
	17th cell = q2 (IRF to GRF)
	18th cell = q3 (IRF to GRF)
	19th cell = q4 (IRF to GRF)
------- Transformation LNOF to GRF pushbutton: Processing of the loaded data. After a successful
	calculation, you automatically take the "VGRF_gradients.mat" and "VGRF_gradients_Report.txt"
	outputs and the below pushbuttons are enabled.
------- Statistics of the data in GRF (.mat) & Report pushbutton:calculates the statistics of the
	processed files with a corresponding report, including the necessary information.
------- Figures of the data in GRF pushbutton:creates figures with the transformed GG's in GRF,
	in time domain.
----------------------------------------------------------------------------------------------------
▪In Display panels:
In the left Display panel the original Vzz gravity gradient(Eötvös)in GRF and the transformed
one in LNOF are presented, while in the right Display panel the original Vzz gravity gradient(Eötvös)
in LNOF and the transformed one in GRF are presented.


===================================================================================================
				GeoGravGOCE, GravLab, AUTh, 2021
===================================================================================================
