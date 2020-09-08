function targetColor = determineColor(I) 
    Bstandard = 107;
    Rstandard = 113;
    Ib = I(:,:,3);
    Ir = I(:,:,1);
    Igray = rgb2gray(I);
    idx = Igray == 0;
    targetColor = [120 0 220];
    Bave = uint8(mean(Ib(~idx)));
    Rave = uint8(mean(Ir(~idx)));
    if Bave/Bstandard < 0.25
        targetColor = [48 0 88];
    end
end