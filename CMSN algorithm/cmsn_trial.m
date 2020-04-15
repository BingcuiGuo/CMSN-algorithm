%we read in the data and format it 
input_data = formatting_data(cats, 17, 12, 3, 1601);

%split into test and training idata
training_test = training_test_split(input_data, 0.7, 12,1601,3,17);
cmsn_training_data = training_test{1,1};
cmsn_training_data = cmsn_training_data(1:1600, 1:6,1,1:17*9); 
cmsn_test_data = training_test{1,2}; 
cmsn_test_data = cmsn_test_data(1:1600, 1:6,1,1:17*3); 

%create training and test label for the cnn stage
training_test_label = creating_label(17, 12, 0.7); 
training_label_cmsn = training_test_label{1,1};
test_label_cmsn = training_test_label{1,2}; 

%train the first stage of cnn 
trained_cnn_net_cmsn = cmsn_cnn_net(12,17,cmsn_training_data,9,3);

%create the input data for the first stage
first_stage_input = ...
   create_first_input_mst(trained_cnn_net_cmsn, 12, cmsn_training_data,17,9);

%training the network
smaller_bacth_size = [5 7 9];
stage_num = 3;
neuron_per_stage = [10 10 10];
mlp_per_stage = [68 68 68];
layer_per_stage = [2 2 2]; 


%create final label for the final stage of MST training 
final_label = create_final_label(17,9); 

%get the final output of MST and the trained net 
cmsn_net_mlps_and_input = cmsn(final_label, 9, layer_per_stage,first_stage_input, ...
   17,stage_num, mlp_per_stage, neuron_per_stage, smaller_bacth_size); 

cmsn_net_mlps = cmsn_net_mlps_and_input{1,2}; 

%test_cmsn

%the input data of the test set will be [1600,6,1,17*3]
%first it would need to go through all the cnn_net 
first_stage_test = create_first_input_mst(trained_cnn_net_cmsn, 12,...
    cmsn_test_data,17,3);

%produce the output from the trained cmsn net 

%then we would need to let the first_stage_test whose size is [204 51] as
%the input for mst and produce a label of [1 51] 
predictedLabels_cmsn = cmsn_testing(first_stage_test, cmsn_net_mlps,17*3,68);

cmsn_accuracy = sum(predictedLabels_cmsn==test_label_cmsn)/numel(test_label_cmsn); 

