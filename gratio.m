function r = gratio(inner_area, myelin_area)
%     if (inner_area/myelin_area >= 0.95) 
%         r = 0;
%     else
    myelin_area = myelin_area*1.48 + 150;
    d_axon = 2*sqrt(inner_area/3.14);
    d_myelin_axon = 2*sqrt(myelin_area/3.14);
    r = d_axon/d_myelin_axon;
    %end
end
