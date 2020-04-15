function[train_label] = create_final_label(label_size, sample)
%this would produce the final label according to the sample size that we
%have for the MST but the output is of type double 
train_label = zeros(1,sample*label_size); 

for i = 1:label_size
    train_label(1,(i-1)*sample+1:i*sample) = i * ones(1,sample);
end