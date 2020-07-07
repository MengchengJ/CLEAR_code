% function Droplets_Label_doubleColor
% label the identified position on both channel of images
%%
function Droplets_Label_doubleColor(dir,M1,MaxPos1,M2,MaxPos2)
LabelM1=M1;
a=5;
for i=1:size(MaxPos1,1)
    if MaxPos1(i)~=[0 0 0]
        x0=MaxPos1(i,1);
        y0=MaxPos1(i,2);
        z0=MaxPos1(i,3);
        LabelM1(x0-a:x0+a,y0,z0)=0;
        LabelM1(x0,y0-a:y0+a,z0)=0;
    end
end
LabelM2=M2;
a=5;
for i=1:size(MaxPos2,1)
    if MaxPos2(i)~=[0 0 0]
        x0=MaxPos2(i,1);
        y0=MaxPos2(i,2);
        z0=MaxPos2(i,3);
        LabelM2(x0-a:x0+a,y0,z0)=0;
        LabelM2(x0,y0-a:y0+a,z0)=0;
    end
end
LabelM=[LabelM1,LabelM2];
Volum2ImgSequence(dir,LabelM);
disp('Label Complete!');
end