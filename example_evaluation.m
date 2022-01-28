% in terminal, create "number only" versions of labels.txt
%for i in `ls -d *.ica`; do tail $i/filtered_func_data.ica/labels.txt -n 1 > $i/filtered_func_data.ica/labels_c.txt; done
%for i in `ls -d *.ica`; do cat $i/filtered_func_data.ica/labels_c.txt | tr -s '\[' ' ' > $i/filtered_func_data.ica/labels_cut.txt ; done
%for i in `ls -d *.ica`; do cat $i/filtered_func_data.ica/labels_cut.txt | tr -s '\]' ' ' > $i/filtered_func_data.ica/labels_c.txt ; done

%for i in `ls -d *.ica`; do tail $i/filtered_func_data.ica/labels2.txt -n 1 > $i/filtered_func_data.ica/labels2_c.txt; done
%for i in `ls -d *.ica`; do cat $i/filtered_func_data.ica/labels2_c.txt | tr -s '\[' ' ' > $i/filtered_func_data.ica/labels2_cut.txt ; done
%for i in `ls -d *.ica`; do cat $i/filtered_func_data.ica/labels2_cut.txt | tr -s '\]' ' ' > $i/filtered_func_data.ica/labels2_c.txt ; done

%navigate to the directory where the MELODIC processed data is located and find all subject folders
%below script works for directories with the structure: 
% sub-001/filtered_func_data.ica
% sub-002/filtered_func_data.ica
% ...
  
%% next, in matlab or octave calculate the agreement with manual labeling using the cofusion matrix
addpath('<path to alt>\ALT');

folders=cellstr(ls); % 

for i=1:length(folders)
manual_labels=dlmread(strcat(folders{i}, '/filtered_func_data.ica/labels_c.txt'));
[confusion(i,:), propsignal(i)]=evaluation(folders{i}, manual_labels); 
end

figure; violinplot(confusion)
mean(confusion)
