function[one_zero_train_label] = creating_zero_one_label(training_size, label_size)
%this function would produce the number of label size of cells and each 
%contains 0 and 1 labels with the corresponding position of batch size to
%be 1. Say batch size is 3, and the first cell is 111 0.... and the second
%cell is 000 111 00... etc. and this would be used in the first second
%stage of mst trianing

one_zero_train_label = cell(1,label_size); 

for i = 1:label_size
    mst_train_label = zeros(1,training_size*label_size);
    mst_train_label(1,(i-1)*training_size+1:i*training_size) = ones(1,training_size); 
    one_zero_train_label{1,i} = mst_train_label; 
end
