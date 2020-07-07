function [NeighborDropCount1,NeighborDropCount2]=F_doubleChannelPositionMatch(Pos1,Pos2,RadiusThreshold)
PosPixel1=zeros(670,480,560);
PosPixel2=PosPixel1;
PosNum1=size(Pos1,1);
PosNum2=size(Pos2,1);
for i=1:PosNum1
    PosPixel1(Pos1(i,1),Pos1(i,2),Pos1(i,3))=1;
end
for i=1:PosNum2
    PosPixel2(Pos2(i,1),Pos2(i,2),Pos2(i,3))=1;
end
NeighborDropCount1=zeros(1,PosNum1);
NeighborDropCount2=zeros(1,PosNum2);
SE=strel('sphere',RadiusThreshold);
for i=1:PosNum1
    PosNeighbor=PosPixel2(Pos1(i,1)-RadiusThreshold:Pos1(i,1)+RadiusThreshold,Pos1(i,2)-RadiusThreshold:Pos1(i,2)+RadiusThreshold,Pos1(i,3)-RadiusThreshold:Pos1(i,3)+RadiusThreshold);
   PosNeighbor=PosNeighbor.*SE.Neighborhood;
    NeighborDropCount1(i)=sum(PosNeighbor(:));
end
for i=1:PosNum2
    PosNeighbor=PosPixel1(Pos2(i,1)-RadiusThreshold:Pos2(i,1)+RadiusThreshold,Pos2(i,2)-RadiusThreshold:Pos2(i,2)+RadiusThreshold,Pos2(i,3)-RadiusThreshold:Pos2(i,3)+RadiusThreshold);
   PosNeighbor=PosNeighbor.*SE.Neighborhood;
    NeighborDropCount2(i)=sum(PosNeighbor(:));
end
end