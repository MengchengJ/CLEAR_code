%% Method : Blinking Pixel
% function findConnectedDroplets
% find the droplet positions whose distances are lower than threshold
%%
function [TrueMaxPos,NeighborDropCount,NoConnMaxPos]=findConnectedDroplets(MaxPos1,RadiusThreshold,RadiusThresholdZ)
MaxPosIndex=find(MaxPos1(:,1)~=0);
for i=1:length(MaxPosIndex)
    TrueMaxPos(i,:)=MaxPos1(MaxPosIndex(i),:);
end
NoConnMaxPos=[];
PosPixel=zeros(830,550,560);
for i=1:length(MaxPosIndex)
    PosPixel(TrueMaxPos(i,1),TrueMaxPos(i,2),TrueMaxPos(i,3))=1;
end
SE=strel('sphere',RadiusThreshold);
NeighborDropCount=zeros(1,length(MaxPosIndex));
PosPixe2=PosPixel;
NeighborDropCount2=zeros(1,length(MaxPosIndex));
for i=1:length(MaxPosIndex)
    PosNeighbor=PosPixel(TrueMaxPos(i,1)-RadiusThreshold:TrueMaxPos(i,1)+RadiusThreshold,TrueMaxPos(i,2)-RadiusThreshold:TrueMaxPos(i,2)+RadiusThreshold,TrueMaxPos(i,3)-RadiusThresholdZ:TrueMaxPos(i,3)+RadiusThresholdZ);
   PosNeighbor=PosNeighbor.*SE.Neighborhood;
    NeighborDropCount(i)=sum(PosNeighbor(:))-1;
    PosNeighbor2=PosPixe2(TrueMaxPos(i,1)-RadiusThreshold:TrueMaxPos(i,1)+RadiusThreshold,TrueMaxPos(i,2)-RadiusThreshold:TrueMaxPos(i,2)+RadiusThreshold,TrueMaxPos(i,3)-RadiusThresholdZ:TrueMaxPos(i,3)+RadiusThresholdZ);
    PosNeighbor2=PosNeighbor2.*SE.Neighborhood;
    NeighborDropCount2(i)=sum(PosNeighbor2(:))-1;
    if  PosPixe2(TrueMaxPos(i,1),TrueMaxPos(i,2),TrueMaxPos(i,3))==1
        if    NeighborDropCount2(i)>0
            NoConnMaxPos=[NoConnMaxPos;[TrueMaxPos(i,1),TrueMaxPos(i,2),TrueMaxPos(i,3)]];
            PosPixe2(TrueMaxPos(i,1)-RadiusThreshold:TrueMaxPos(i,1)+RadiusThreshold,TrueMaxPos(i,2)-RadiusThreshold:TrueMaxPos(i,2)+RadiusThreshold,TrueMaxPos(i,3)-RadiusThresholdZ:TrueMaxPos(i,3)+RadiusThresholdZ)=0;             
        end
        if    NeighborDropCount2(i)==0
            NoConnMaxPos=[NoConnMaxPos;[TrueMaxPos(i,1),TrueMaxPos(i,2),TrueMaxPos(i,3)]];
        end
    end
end
length(find(NeighborDropCount>0));

end