function[input_data] = formatting_data(raw_data,label_size, sample_size,angle_size,row_num)
%thie function would take a matrix with 17 cells as input and format them
%to be a 4d matrix, which size (row_num, angle_size*2, 1,
%total_sample_size); 

%create a 4d matrix which has the same size of the desired (1600,6,1,
%12*17); 
%and we would select 1,13,25's sample in each category for one entry in the
%final matrix 
input_data = zeros(row_num, 2*angle_size,1,sample_size*label_size); 
counter=1; 
base_line1 = sample_size;
base_line2 = sample_size*2; 
for i = 1:label_size
    % we are go through the 17 labels 
    current_label = raw_data{1,i}; 
    for j = 1:sample_size
        %create the corresponding specific entrys corresponding to these
        %smaple, and for the 1st, it corresponds to 1,13,25th; second it is
        %2, 14,26
        corresponding_num = [j j+base_line1 j+base_line2];
        for k = 1:angle_size
            %get the current corresponding matrix 
            current_corresponding_num = corresponding_num(k);
            current_sample = current_label{1,current_corresponding_num};
            %the input with 1 and 4 should correspondes to angle 1,which is
            %the 1st one, 2,5 should correspondes to angle2, which is the
            %13th, so on and so on. 
            input_data(1:row_num, k,1,counter) = current_sample(1:row_num,2);  
            input_data(1:row_num, k+angle_size, 1, counter) = current_sample(1:row_num,3); 
        end
       counter = counter+1; 
    end
end




