%%
% function Droplets_Label
% label identified position of droplets on the original images to verify
% the accuracy of counting process
%
%%
function Droplets_Label(dir,M,MaxPos1)
a=5;
LabelM=M;
for i=1:size(MaxPos1,1)
    if MaxPos1(i)~=[0 0 0]
        x0=MaxPos1(i,1);
        y0=MaxPos1(i,2);
        z0=MaxPos1(i,3);
        LabelM(x0-a:x0+a,y0,z0)=0;
        LabelM(x0,y0-a:y0+a,z0)=0;
    end
end
Volum2ImgSequence(dir,LabelM);
disp('Label Complete!');
end