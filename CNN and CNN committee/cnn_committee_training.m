%create the cnn committee net combinaiton
cnn_committee_net = cnn_committee(12, cnn_training_data, training_label_cnn,17); 

%create test total result by using classify 
test_total_result = zeros(12,3*17);
test_total_result = categorical(test_total_result); 
for i = 1:12
    current_net = cnn_committee_net{1,i};
    test_total_result(i,1:3*17) = classify(current_net, cnn_test_data)';
end

%create the result resulting from majority vote
[final_label,F] = mode(test_total_result);

%calculate accuracy 
cnn_committee_accuracy = sum(final_label==test_label_cnn)/numel(test_label_cnn); 