%%
% This code is used to process the raw image, get the raw intensity,
% position, and template correlation
%
%%
clear
addpath('.\DropletsCountingLib');
% loading data and initializtion
xrange=480;
ystart=1;
yrange=670;
zstart=1;
zrange=560;
baseDirectory='';
groupName='ABCDEN';
    
for foldNum=1:6
    for channelNum=1:2
        directory=[baseDirectory,'\sample'];%% file location
        folder =[directory,num2str(foldNum)];
        disp(folder);
        %% load stacks of images into a 3D matrix, fft2 processing
        [M,K]=ImgSeq2MK(folder,channelNum,560);
        %% Search for positions of local maxima
        tic
        disp('counting local maxima');
        [B0,MaxPos,~,~]=MinimaMaxima3D(K,1,0);
        toc
        %% Template matching
        %load('Tem3D.mat');template=Tem3;
        load('template11_0928.mat')
        template=Tm;
        maxTk=6;
        Max_T=max(max(template(:,:,maxTk)));
        [maxTi ,maxTj]=find(template(:,:,maxTk)==Max_T);
        [rowT,colT,stkT]=size(template);
        [MaxNum,~]=size(MaxPos);
        MaxPos0=zeros(size(MaxPos));
        % to make sure margin area will not be considered
        margin=2;
        for i=1:MaxNum
            if yrange-MaxPos(i,1)>margin*rowT && MaxPos(i,1)>margin*rowT
                if xrange-MaxPos(i,2)>margin*colT && MaxPos(i,2)>margin*colT
                      if MaxPos(i,3)>stkT*margin && zrange-MaxPos(i,3)>stkT*margin
                            MaxPos0(i)=MaxPos(i);
                      end 
                end
            end
        end
        R0=zeros(MaxNum,1);
        C0=R0;
        template_avg=sum(sum(sum(template)))/(rowT*colT*stkT);
        template_ctr=template_avg*ones(size(template));
        template_od=template-template_ctr;
        template_od_sqrsum_sqrt=sum(sum(sum(template_od.^2))).^(0.5);
        %%
        disp('templat Maching');
        tic
        edge=3;
        for i=1:MaxNum
            if MaxPos0(i)~=[0 0 0]
                tempXstart=MaxPos(i,1)-maxTi+1;
                tempXend=MaxPos(i,1)-maxTi+rowT;
                tempYstart=MaxPos(i,2)-maxTj+1;
                tempYend=MaxPos(i,2)-maxTj+colT;
                tempZstart=MaxPos(i,3)-maxTk+1;
                tempZend=MaxPos(i,3)-maxTk+stkT;
                temp=K(tempXstart:tempXend,tempYstart:tempYend,tempZstart:tempZend);
                if sum(sum(sum(temp.^2)))~=0
                    temp_avg=sum(sum(sum(temp)))/(rowT*colT*stkT);
                    temp_od=temp-temp_avg*ones(rowT,colT,stkT);
                    R0(i)=sum(sum(sum(temp_od.*template_od)))/template_od_sqrsum_sqrt/sqrt(sum(sum(sum(temp_od.^2))));
                end       
                frt=K(tempXstart,MaxPos(i,2),MaxPos(i,3));
                rer=K(tempXend,MaxPos(i,2),MaxPos(i,3));
                rit=K(MaxPos(i,1),tempYstart,MaxPos(i,3));
                lef=K(MaxPos(i,1),tempYend,MaxPos(i,3));
                up=K(MaxPos(i,1),MaxPos(i,2),tempZstart);
                dwn=K(MaxPos(i,1),MaxPos(i,2),tempZend);
                C0(i)=K(MaxPos(i,1),MaxPos(i,2),MaxPos(i,3))-(frt+rer+rit+lef+up+dwn)/6;
            end
        end
        clear T
        toc
        %% filter
        R=zeros(size(R0));
        C=R;B=R;
        Corr_thr= ;% R threshold
        C_thr= ; % Contrast threshold
        B_thr= ;% Brightness of maxima, threshold

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
        D=C.*R.*B;
        Dcount=sum(D);
        MaxPos1=MaxPos.*[D,D,D];
        ResultName=[folder,'_',num2str(channelNum)];      
        save(ResultName,'MaxPos','MaxPos1','Dcount','R0','C0','B0','Corr_thr','C_thr','B_thr');
   end
end
    
    
    
    
    