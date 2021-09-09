function cleaning (input_dir, gmthresh, fthresh)
%set default thresh parameters
if nargin<3
  fthresh = 0.6;
end

if nargin<2
  gmthresh = 0.5;
end
%% in octave:
curr_wd=pwd;
addpath(curr_wd);
%%% 1. assess how many % of voxels from this component are in the gray matter
cd(input_dir)
#/media/sf_Canada_2020/OASIS/data/fMRI/sub-OAS30003/ses-d2669/func/sub-OAS30003_ses-d2669_task-rest_run-01_bold.ica

fullvol=dlmread('./alt/fullvol.txt');
gmvol=dlmread('./alt/gmvol.txt');
gm_prop=gmvol./fullvol;

%power and ts
for i=1:length(gm_prop)
%ts
file=strcat('./filtered_func_data.ica/report/t', num2str(i), '.txt');
ts(:,i)=dlmread(file);
%power spectra
file=strcat('./filtered_func_data.ica/report/f', num2str(i), '.txt');
f=dlmread(file);
fsignal=trapz( f(1:round(length(f)*0.35) ) );
fall=trapz( f(1:length(f) ) );
f_prop(i,1)=fsignal/fall;
end

%figure; plot(gm_prop);figure; plot(f_prop);
signal=(gm_prop>0.5 & f_prop>0.6);
noise=find(signal==0);
dlmwrite('./alt/prop_signal.txt', mean(signal) );
dlmwrite('./alt/signal_labels.txt', find(signal==1) );
dlmwrite('./alt/noise_labels.txt', noise', 'delimiter', ',');
cd(curr_wd)
