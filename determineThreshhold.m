function thresh = determineThreshhold(I)
    Bstandard = 107;
    Ib = I(:,:,3);
    Ir = I(:,:,1);
    Igray = rgb2gray(I);
    idx = Igray == 0;
    thresh = 150;
    Bave = uint8(mean(Ib(~idx)));
    Rave = uint8(mean(Ir(~idx)));
    if Bave/Bstandard < 0.3
        thresh = 80;
    end
end