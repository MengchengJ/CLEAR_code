%%
% function F_edgeDropDetection
% remove the false positive max positions on the edge of the tube
%%
function [Ecount,MaxPos2,E0]=F_edgeDropDetection(M,MaxPos,edge,bri_thre,E_thr)
MaxNum=size(MaxPos,1);
E0=zeros(MaxNum,1);
E=E0;
T=zeros(size(M));
T(M<bri_thre)=-1;  
T(M>10000)=1;
El_thr=((2*edge)^3)*(E_thr-1);
    for i=1:MaxNum
        tempXstart=MaxPos(i,1)-edge+1;
        tempXend=MaxPos(i,1)+edge;
        tempYstart=MaxPos(i,2)-edge+1;
        tempYend=MaxPos(i,2)+edge;
        tempZstart=MaxPos(i,3)-edge+1;
        tempZend=MaxPos(i,3)+edge;
        tempE=T(tempXstart:tempXend,tempYstart:tempYend,tempZstart:tempZend);
        E0(i)=sum(sum(sum(tempE)));        
        if E0(i)>El_thr
        E(i)=1;
        end
        MaxPos2=MaxPos(E==1,:);
    end
    Ecount=sum(E);
end
