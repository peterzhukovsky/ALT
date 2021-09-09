#!/bin/sh
# ICA - ALT (Automated labeling tool): An FSL-based script that requires feat/melodic_gui outputs with a reg folder
# This script generates stats on how much of each component falls under the GM mask
# It takes as the first argument a full path to the .ica or .feat folder and as a second argument a full path to the GM template location
# Example:
# user:myshell$ ./alt.sh /media/data/fMRI/sub-XXXX/func/sub-XXXX_task-rest_run-01_bold.ica /media/data/fMRI/templates/all_GM.nii.gz
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

cd $1 #/media/sf_Canada_2020/OASIS/data/fMRI/sub-OAS30003/ses-d2669/func/sub-OAS30003_ses-d2669_task-rest_run-01_bold.ica
## firstly figure out what's gray, white and csf
mkdir alt

#template=$2 #/media/sf_Canada_2020/OASIS/data/fMRI/templates/all_GM.nii.gz
template=${2:-$SCRATCH/OASIS/scripts/fmri/ALT/all_GM.nii.gz} #set the default location of the GM template

flirt -in ./filtered_func_data.ica/melodic_IC -ref ./reg/standard -out ./alt/melodic_IC_instd -init ./reg/example_func2standard.mat -applyxfm

fslsplit ./alt/melodic_IC_instd ./alt/melodic

cd alt; rm fullvol.txt gmvol.txt
for i in `ls melodic0*`; do
fslmaths $i -thr 2 $i
fslstats $i -V >tmp.txt
awk 'NR == 1 {print $1}' tmp.txt >> fullvol.txt
fslmaths $i -mas $template $i
fslstats $i -V >tmp.txt
awk 'NR == 1 {print $1}' tmp.txt >> gmvol.txt
rm $i
done; rm tmp.txt; cd ..

#ts and power spectra can be found in ./filtered_func_data.ica/report/t26.txt


