JAX38_contra = {'JAX38 contra fascicle1 - 60x','JAX38 contra  fascicle2 - 60x'};
JAX38_ipsi = {'JAX38 ipsi 60x fascicle1','JAX38 ipsi 60x fascicle2','JAX38 ipsi 60x fascicle3','JAX38 ipsi 60x fascicle4'};
JAX39_contra = {'JAX39 contra 60x fascicle1', 'JAX39 contra 60x fascicle2'};
JAX39_ipsi = {'JAX39 ipsi 60x fascicle1','JAX39 ipsi 60x fascicle2'};
JAX40_contra = {'JAX40 contra fascicle2 - 60x','JAX40 contra fascicle3 - 60x','JAX40 contra fascicle4,5 - 60x'};
JAX40_ipsi = {'JAX40 ipsi fascicle1 - 60x','JAX40 ipsi fascicle4 - 60x','JAX40 ipsi fascicle5 - 60x','JAX40 ipsi  fascicle2,3 - 60x'};
JAX41_ipsi = {'JAX41 ipsi fascicle1 - 60x','JAX41 ipsi  fascicle2 - 60x'};
JAX42_ipsi = {'JAX42 ipsi fascicle1 - 60x','JAX42 ipsi fascicle3 - 60x'};
JAX44_ipsi = {'JAX44 ipsi fascicle1 - 60x','JAX44 ipsi fascicle5,6 - 60x','JAX44 ipsi  fascicle2,3,4 - 60x'};
JAX45_contra = {'JAX45 contra 60x fascicle1','JAX45 contra 60x fascicle2,3,4','JAX45 contra 60x fascicle5'};
JAX45_ipsi = {'JAX45 ipsi 60x fascicle1','JAX45 ipsi 60x fascicle2','JAX45 ipsi 60x fascicle3'};

%% JAX38 contra
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX38_contra,'JAX38 contra');
%% JAX38 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX38_ipsi,'JAX38 ipsi');
%% JAX39 contra
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX39_contra,'JAX39 contra');
%% JAX39 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX39_ipsi,'JAX39 ipsi');
%% JAX40 contra
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX40_contra,'JAX40 contra');
%% JAX40 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX40_ipsi,'JAX40 ipsi');
%% JAX41 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX41_ipsi,'JAX41 ipsi');
%% JAX42 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX42_ipsi,'JAX42 ipsi');
%% JAX44 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX44_ipsi,'JAX44 ipsi');
%% JAX45 contra
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX45_contra,'JAX45 contra');
%% JAX45 ipsi
[avggratiobatch, allgratiosbatch] = BatchGratioVer2(JAX45_ipsi,'JAX45 ipsi');










