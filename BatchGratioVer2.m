function [avggratiobatch, allgratiosbatch] = BatchGratioVer2(files,group_name)
    %allgratiosbatch = zeros(1,100);
    for ii = 1:length(files)
        filename = strcat([files{ii},'.png']);
        [~, allgratios] = IndvGratioVer2(filename);
        if ii == 1
            allgratiosbatch = allgratios;
        else
            allgratiosbatch = cat(2,allgratiosbatch,allgratios);
        end
    end
    avggratiobatch = mean(allgratiosbatch);
    histogram(allgratiosbatch,'NumBins',8);
    title(strcat([group_name, ' ', '(', 'n = ', num2str(length(allgratiosbatch)),',',' ','avg = ',num2str(avggratiobatch),')']));
end