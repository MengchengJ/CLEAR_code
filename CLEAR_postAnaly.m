clear all
addpath('.\DropletsCountingLib');
xrange=480;
ystart=1;
yrange=670;
zstart=1;
zrange=560;
BackIntense=[];
baseDirectory='';

for foldNum=1:6
    folder =fullfile(baseDirectory,['sample',num2str(foldNum)]);
    folder_488= [folder,'_1'];
    folder_532= [folder,'_2']; 
    disp(['foldNum=',num2str(foldNum)]);
    load([folder_488,'.mat']);
    %% load stacks of images into a 3D matrix, fft2 processing
    [M1,K1]=ImgSeq2MK(folder,1,560);
    [BackIntense1,~]=F_getVolumeBackIntense(M1,6000,2000);
    [MaxNum,~]=size(MaxPos1);
    R=zeros(size(R0));
    C=R;B=R;E=R;
    Corr_thr=;  % R threshold
    C_thr= ;    % Contrast threshold
    B_thr= ;    % Brightness threshold
    for i=1:MaxNum  
        if B0(i)>B_thr
            B(i)=1;
        end
        if C0(i)>C_thr
            C(i)=1;
        end
        if R0(i)>Corr_thr
            R(i)=1;
        end
    end
    DcountR=sum(R);
    DcountB=sum(B);
    DcountC=sum(C);
    El_thr=-46656+46656*0.95; 
    E_thr=El_thr;
    D=C.*R.*B;
    Dcount=sum(D);
    MaxPos2=MaxPos1.*[D,D,D];
    FFTIntense=B0.*D;
    [~,NeighborDropCount,NoConnMaxPos1]=findConnectedDroplets(MaxPos2,3,3,FFTIntense);
    DcountN1=length(NeighborDropCount)-sum(NeighborDropCount)/2;
    [Ecount1,MaxPosE1,~]=F_edgeDropDetection(M1,NoConnMaxPos1,10,2000,0.55);
    folder5= [baseDirectory,'/LabeledDrop/sample',num2str(foldNum)];
    Droplets_Label(folder5,M1,MaxPosE1);
    CountResults(foldNum,:)=[Ecount1;BackIntense1];
end
disp('Done!');
save([baseDirectory,'_countResults.mat'],'CountResults','BackIntense');
