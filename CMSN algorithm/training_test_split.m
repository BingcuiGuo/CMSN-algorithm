function[training_test] = training_test_split(input_data, training_percent, sample_size,row_num,angle_size,label_size)
%this function would split the input data into training set and test set
%according to the training_percent given. And it would output a cell which
%contains 2 blanks, with the first one being the training set and the
%second one being the test set. 

%specify training size and test size 
training_size = ceil(sample_size*training_percent);
test_size = sample_size-training_size; 

%this would create the output and specify the desired format of
%training_data and test data 
training_test = cell(1,2);
training_data = zeros(row_num, angle_size*2, 1, label_size*training_size);
test_data = zeros(row_num, angle_size*2, 1, label_size*test_size);

% create training data
counter_training = 1;
counter_test = 1;
%we would go through all the label_size 
for j = 1:label_size
    %this would generate random number of sample size, in this case would
    %be to randomly permutate the number 12 and base_index means which
    %sample group we are at (they are seperated as 0, 12, 24, ...) 
    rand_index = randperm(sample_size);
    base_index = (j-1)*sample_size; 
   for i = 1:training_size
       %we would select the first nine number in a category and use these 9
       %as the training sample for this category 
       training_data(1:row_num, 1:angle_size*2,1,counter_training) = input_data(1:row_num,...
           1:angle_size*2, 1, base_index+rand_index(i));
       counter_training = counter_training+1; 
   end
   for k = 1:test_size
       %we would select the remaning three numbre in a category and use
       %these 3 as the test sample for this category 
       test_data(1:row_num, 1:angle_size*2,1,counter_test) = input_data(1:row_num,...
           1:angle_size*2, 1, base_index + rand_index(training_size+k));
       counter_test = counter_test+1; 
   end
end

%we assign the training_data and test_data to the output 
training_test{1,1} = training_data;
training_test{1,2} = test_data; 


