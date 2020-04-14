function [cnn_network] = cnn_network(training_data, training_label,label_size)

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

%train the network
cnn_network = trainNetwork(training_data, training_label, cnn_layers, options);



