%format the input data into the desired form 
input_data = formatting_data(cats, 17, 12, 3, 1601);

%split into test and training data by 0.7 as training data and the
%remaining for test sets 
training_test = training_test_split(input_data, 0.7, 12,1601,3,17);
fcn_training_data = training_test{1,1};
fcn_training_data = fcn_training_data(1:1600, 1:6,1,1:17*9); 
fcn_test_data = training_test{1,2}; 
fcn_test_data = fcn_test_data(1:1600, 1:6,1,1:17*3); 

%create training and test label
training_test_label = creating_label(17, 12, 0.7); 
training_label_fcn = training_test_label{1,1};
test_label_fcn = training_test_label{1,2}; 

%training the network
fcn_net = fcn_network(fcn_training_data, training_label_fcn,17); 

%test the network
predictedLabels_fcn = classify(fcn_net, fcn_test_data);
fcn_accuracy = sum(predictedLabels_fcn'==test_label_fcn)/numel(test_label_fcn); 
