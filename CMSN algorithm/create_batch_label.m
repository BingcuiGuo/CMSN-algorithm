function[train_label] = create_batch_label(label_size, batch_size)
%this function would produce the number of label size of cells according to
%the batch size with 111 222 333 ... used in cmsn_cnn_net
train_label = zeros(1,batch_size*label_size); 

for i = 1:label_size
    train_label(1,(i-1)*batch_size+1:i*batch_size) = i * ones(1,batch_size);
end

train_label = categorical(train_label); 

