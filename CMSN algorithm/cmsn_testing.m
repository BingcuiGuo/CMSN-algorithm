function[final_label] = cmsn_testing(test_data,pretrained_nets,sample_size,mlp_num)
%this function would take the test data, pretrained_net and sample size and
%put the test data to pretrained nets in order to get the predicted label 
[row_num, n_stage] = size(pretrained_nets);
for i = 1:n_stage
    [row_num_stage, mlp_num] = size(pretrained_nets{1,i});
    current_stage_data = zeros(mlp_num, sample_size);
    current_stage_net = pretrained_nets{1,i}; 
    for j = 1:mlp_num
        current_net = current_stage_net{1,j};
        current_stage_one_sample = current_net(test_data); 
        current_stage_data(j,1:sample_size) = current_stage_one_sample; 
    end
    test_data = current_stage_data;
end


for i = 1:sample_size
    for j = 1:mlp_num
       test_data(j,i) = round(test_data(j,i));
    end
end

[final_label,F] = mode(test_data);
final_label = categorical(final_label); 






