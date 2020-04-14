%format the data 
input_data = formatting_data(cats, 17, 12, 3, 1601);

%split into test and training data
training_test = training_test_split(input_data, 0.7, 12,1601,3,17);
cnn_training_data = training_test{1,1};
cnn_training_data = cnn_training_data(1:1600, 1:6,1,1:17*9); 
cnn_test_data = training_test{1,2}; 
cnn_test_data = cnn_test_data(1:1600, 1:6,1,1:17*3); 

%create training and test label
training_test_label = creating_label(17, 12, 0.7); 
training_label_cnn = training_test_label{1,1};
test_label_cnn = training_test_label{1,2}; 

%training the network
cnn_net = cnn_network(cnn_training_data, training_label_cnn,17); 

%test the network
predictedLabels_cnn = classify(cnn_net, cnn_test_data);
cnn_accuracy = sum(predictedLabels_cnn'==test_label_cnn)/numel(test_label_cnn); 


