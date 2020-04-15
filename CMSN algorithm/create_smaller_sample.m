function[smaller_sample] = create_smaller_sample(label_size, mlp_size, sample_size, batch_size,input_data)
%this function would take the full sample data and mlp_size and batch size
%and select some random samples from each categories and produce smaller
%training sample like this of the mlp_size cells and return the cell as
%output it is all of 2d for the mst stages and the output is a cell with
%mlp_size blanks and this would be used in mst stage in cmsn 
%the output's size would be a cell with mlp_size of blanks 

[row_num, col_num] = size(input_data); 
smaller_sample = cell(1,mlp_size);
%we go through each of the mlp_size blank
for i = 1:mlp_size
    training_random_sample = zeros(row_num, batch_size*label_size); 
    counter_sample = 1;
     %we would produce the random permutation of sample size and get the
    %first batch size ones as our input
     random_index = randperm(sample_size); 
     random_index_in_use = random_index(1:batch_size);
    for j = 1:label_size
        base_num = sample_size; 
        %for each one in the batch size, we would like to get the
        %base_num*(j-1) (which category) + random_index_in_use(k) sample
        %into our output sample 
        for k = 1:batch_size 
            training_random_sample(1:row_num, counter_sample) = input_data(1:row_num,...
                base_num*(j-1)+random_index_in_use(k));
            counter_sample = counter_sample +1; 
        end
    end
    smaller_sample{1,i} = training_random_sample;
 
end