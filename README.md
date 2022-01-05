# ALT
Alternative Labeling Tool for labeling independent components derived from FSL MELODIC/FEAT as signal vs noise

# Installation
ALT requires a working installation of FSL and octave or matlab (tested on matlab R2016a)

# Example walkthrough
1) First, run alt.sh on the melodic folder to generate the % of IC falling in gray matter and IC's power spectrum skewness metrics
    
    alt.sh <mypathtofolder>/sub-001_rsfmri.ica
2) Second, run cleaning.m on the melodic folder to generate the signal vs noise label 
    
    (in octave or matlab): cleaning('<mypathtofolder>/sub-001_rsfmri.ica')
3) Optional: use manual labeling on a number of scans and compare labeling performance of ALT with manual ratings using evaluation.m
    
    evaluation('<mypathtofolder>/sub-001_rsfmri.ica', manual_labels)
  
# Citations
A detailed manuscript on ALT is currently available as a preprint here:
https://assets.researchsquare.com/files/rs-1061924/v1/ceb1b779-4c5c-4109-968d-108bdf1719be.pdf?c=1637336355
