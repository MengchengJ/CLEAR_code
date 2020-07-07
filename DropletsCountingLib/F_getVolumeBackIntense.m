%%
% function  F_getVolumeBackIntense
% get the average intensity of negative droplets for further analysis
%%
function   [BackIntense,validVolume]=F_getVolumeBackIntense(M,Hi_thre,Lo_thre)
T=zeros(size(M));
T(M>Lo_thre)=1;  
T1 = bwareaopen(T,10000000,26);
threConn=1500;
T2=zeros(size(M));
T2(M>Hi_thre)=1;  
ValidPixel=T1.*(~T2);
validVolume=M.*ValidPixel;
validVolume(validVolume==0)=NaN;
BackIntense=nanmean(validVolume(:));
end