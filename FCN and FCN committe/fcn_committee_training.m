%create the cnn committee net combinaiton
fcn_committee_net = fcn_committee(12, fcn_training_data, training_label_cnn,17); 

%create test total result
fcn_test_total_result = zeros(12,3*17);
fcn_test_total_result = categorical(fcn_test_total_result); 
for i = 1:12
    current_net = fcn_committee_net{1,i};
    fcn_test_total_result(i,1:3*17) = classify(current_net, fcn_test_data)';
end

%create the result resulting from majority vote
[fcn_final_label,F] = mode(fcn_test_total_result);

%calculate accuracy 
fcn_committee_accuracy = sum(final_label==test_label_fcn)/numel(test_label_fcn); 