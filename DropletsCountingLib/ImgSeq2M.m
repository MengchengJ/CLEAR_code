% read image sequence into memory and correct vertical intensity
function M=ImgSeq2M(dir,color,PicNum,Correctmat)
for i =1:PicNum
    temp=imread([dir,'\',num2str(color),'_',num2str(i,'%03d'),'.tif']);
    if nargin==3
    M(:,:,i)=double(temp);  
    end
    if nargin==4
    M(:,:,i)=double(temp).*Correctmat;  
    end
end     
 
end