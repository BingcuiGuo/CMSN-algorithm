function[input_data_mst] = create_input_for_next_stage(trained_cnn, mlp_num, input_data,label_size,sample_size)
%preset the output size 
input_data_mst = zeros(mlp_num, label_size*sample_size);
%this function would take all the sample data into all the mlp trained by
%smaller batches and produce the result for next stage
for i = 1:mlp_num
    current_net = trained_cnn{1,i}; 
    input_data_mst(i, 1:label_size*sample_size) =  current_net(input_data);
end
