function[input_data_mst] = create_first_input_mst(trained_cnn, mlp_num, input_data,label_size,sample_size)
%this function would take in the trained cnn nets produced by all the small
%batchs and input all the samples inside in order to get the full result
%for the input data for the MST 
input_data_mst = zeros(mlp_num*label_size, label_size*sample_size);
for i = 1:mlp_num
    current_net = trained_cnn{1,i}; 
    input_data_mst((i-1)*label_size+1:i*label_size, 1:label_size*sample_size) = ...
        predict(current_net, input_data)'; 
end

