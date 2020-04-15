function[cmsn_cnn_net] = cmsn_cnn_net(mlp_size,label_size,input_data,sample_size,batch_size)

%we create a cell containing all the cnn's corresponding batch data sets
cnn_stage_input_data = select_random_sample(label_size, mlp_size, sample_size, batch_size,input_data);
cmsn_cnn_net = cell(1,mlp_size);
%we create the bacth lable for each of the cnn 
train_label = create_batch_label(label_size, batch_size);

%defind network architecture
cnn_layers = [...
    imageInputLayer([1600 6 1])
    
    convolution2dLayer([25 1],8,'Stride', 1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([2 1], 'Stride',2)
    
    convolution2dLayer([5 1],16,'Stride', 1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([2 1],'Stride',2)
    
    convolution2dLayer([3 1],32,'Stride', 1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([2 1],'Stride',2)
    
    convolution2dLayer([3 1],64,'Stride', 1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([2 1],'Stride',2)
    
    
    dropoutLayer(0.25)
    fullyConnectedLayer(50)
    fullyConnectedLayer(label_size)
    softmaxLayer
    classificationLayer
    ];

%%define the options
options = trainingOptions('adam',...
    'InitialLearnRate', 1e-3,...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',5, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'MiniBatchSize', 12,...
    'Plots','training-progress');

%train the network and store them accordingly in the final cell 
for i = 1:mlp_size
training_data_current = cnn_stage_input_data{1,i}; 
cnn_network_current = trainNetwork(training_data_current, train_label, cnn_layers, options);
cmsn_cnn_net{1,i} = cnn_network_current; 
end



