cats = cell(1,17);
angle = {'00','45','90'};
%this .m file would read in the radar data and save them in a cell with 17
%blanks 
for i = 1:17
    %it represents there are 17 categories 
    counter = 1; 
    temp = cell(1,36); 
    for j = 1:3
        %it represents there are 3 angle sizes 
        for k = 1:12
            %it represens there are 12 samples for each angle size 
            filename = strcat(num2str(i, '%02.f'),angle{j},num2str(k, '%02.f'),'.csv');
            temp{1,counter} = readmatrix(filename); 
            counter = counter+1; 
        end
    end
    cats{1,i} = temp; 
end