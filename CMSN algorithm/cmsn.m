function[input_total] = cmsn(train_label, sample_size, layer_per_stage, input_data, ...
    label_size,stage_num, mlp_per_stage, neuron_per_stage, training_size)
%this is a MST function that takes in train_label, which is the final label
%that would come up to use, sample_size to train, layer_per_stage which is
%[2 2 2] and input_data which is the first stage data after the cnn,
%label_size which is 17, stage_num which is 3, mlp_per_stage which is [68
%68 68], neuron_per_stage is [10 10 10], training_size is the smaller batch
%size which is [5 7 9] for each stage 

%we would have a cell which has smaller mlp for each stage 
network_total = cell(1,stage_num); 
input_total = cell(1,3);
for i = 1:stage_num
    %each stage, we calculate the how many mlp corresponds to each category
    classfication_num = mlp_per_stage(i)/label_size;
    
    %we create label with 1 and 0 for all the mlp, and in this case, 4
    %mlp would use the same blank of label and we would get a cell with 17
    %blanks 
    
    current_stage_output_label = creating_zero_one_label(training_size(i), label_size); 
    %we want to use the size to configure our initial data input
    output_sample = current_stage_output_label{1,1};
    
     %create current input data and it would return a 
     current_training_data = create_smaller_sample(label_size, mlp_per_stage(i), ...
         sample_size, training_size(i),input_data);
     current_training_data_example = current_training_data{1,1};
     
    %create general mlp 
    %first initial layer size according to how many neurons that each stage
    %mlp would have in this case would be 2 10 
    layer_size = []
    for j = 1:layer_per_stage(i)
        layer_size = [layer_size neuron_per_stage(i)];
    end
    %we create a mlp with the specified size and configure it to match the
    %size 
    mlp = feedforwardnet(layer_size,'trainlm');
    mlp = configure(mlp, current_training_data_example,output_sample); 
    for k = 1:layer_per_stage(i)
        mlp.layers{k}.transferFcn = 'tansig';
    end
    mlp.layers{k+1}.transferFcn = 'purelin';
    mlp.trainParam.epochs = 3; 

    %our network_stage is the cell that would contain all the trained mlps
    network_stage = cell(1,mlp_per_stage(i)); 

    %train the mlp if it is the last stage and we now have current_training_data
    %which is a cell containing 68 blanks and each have [68 17*9] matrix 
    if i == stage_num
        counter=1; 
    for m = 1:label_size
    for n = 1:classfication_num
        mlp = init(mlp);
        %we train the network with current input data which is the output
        %of the last stage and with the final train lable
        current_input_data = current_training_data{1,counter}; 
        mlp_current = train(mlp,current_input_data,train_label);
        %we set the network stage to be the trained one 
        network_stage{1,counter} = mlp_current; 
        counter = counter + 1; 
    end
    end
    
    %train the stages besides the last one 
    else 
        counter=1; 
    for m = 1:label_size
    for n = 1:classfication_num
        %we get the smaller training_data would be the one with the
        %counterth blank. And the current label is
        %current_stage_output_label{1,m} because 4 mlps would corresponds
        %to the first label, etc.
        mst_training_data = current_training_data{1,counter}; 
        mlp = init(mlp);
        mlp_current = train(mlp, mst_training_data, current_stage_output_label{1,m});
        network_stage{1,counter} = mlp_current; 
        counter = counter + 1; 
    end
    end
    end
    %we replace the input data with the input data produced by the trained
    %mlps
    input_data = create_input_for_next_stage(network_stage, mlp_per_stage(i),...
            input_data,label_size,sample_size);
     input_total{1,i} = input_data; 
    %we replace the network_total{1,i} to be the trained_network_stage
    network_total{1,i} = network_stage;  
end

