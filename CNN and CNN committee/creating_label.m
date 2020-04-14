function[output] = creating_label(label_size, sample_size, training_proportion)
%this function would create training and test labels according to sample size and 
%the corresponding training proportion. The output should be
%1..12...2...17...17 depending on how many samples in each category and the
%output type is categorical. 

%we would get the the training_sample size and test sample size 
training_sample = ceil(sample_size*training_proportion);
test_sample = sample_size - training_sample; 

%we ceate the desired size of train_label and test label and preset all
%of the numbers to be 0
train_label = zeros(1,training_sample*label_size); 
test_label = zeros(1,test_sample*label_size); 

%for each 1:sample size smaller chunk, we replace them by i*ones. 
for i = 1:label_size
    train_label(1,(i-1)*training_sample+1:i*training_sample) = i * ones(1,training_sample);
    test_label(1,(i-1)*test_sample+1:i*test_sample) = i * ones(1,test_sample);
end

%we change the output to be desired format
train_label = categorical(train_label); 
test_label = categorical(test_label); 
output = cell(1,2);
output{1,1} = train_label; 
output{1,2} = test_label;