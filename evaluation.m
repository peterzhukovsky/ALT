function confusion = evaluation(input_dir, manual_labels);
%# example:
%# manual_labels=[1, 2, 3, 4, 6, 7, 8, 9, 11, 12, 15, 16, 17, 19, 20, 21, 23, 24, 25, 27, 28, 31, 33, 34, 36, 37, 38, 39, 40, 41, 42, 43, 45, 47, 50, 51, 52, 53, 54, 55, 56];
%# confusion=evaluation('/media/sub-XXXX_task-rest_run-01_bold.ica/filtered_func_data.ica/', manual_labels)

curr_wd=pwd;
addpath(curr_wd);
cd(input_dir) #eg /media/sf_Canada_2020/OASIS/data/fMRI/sub-OAS30003/ses-d1631/func/sub-OAS30003_ses-d1631_task-rest_run-01_bold.ica/filtered_func_data.ica/

fullvol=dlmread('./alt/fullvol.txt');
ncomp=length(fullvol);

%#file=strcat('./filtered_func_data.ica/', manual_label_id, '.txt');
%#manual_labels=textread(file);
%#manual_labels(isnan(manual_labels))=[];
%#manual_labels(1:ncomp)=[];


auto_labels=dlmread('./fix/noise_labels.txt');


c_manual=zeros(1, ncomp);
c_manual(manual_labels)=1;
c_auto=zeros(1, ncomp);
c_auto(auto_labels)=1;

%#generate confusion matrix:
%#TP, FN
%#TN, FP
TP=sum(c_manual==1 & c_auto==1)/sum(c_manual==1);
TN=sum(c_manual==0 & c_auto==0)/sum(c_manual==0);

FP=sum(c_manual==0 & c_auto==1)/sum(c_manual==0);
FN=sum(c_manual==1 & c_auto==0)/sum(c_manual==1);

confusion=[TP, FN, TN, FP];
