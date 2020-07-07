% convert 3D matrix into image sequence
function Volum2ImgSequence(dir,ImgVol)
mkdir(dir);
[a,b,c]=size(ImgVol);
for n=1:c
   imwrite(uint16(ImgVol(:,:,n)),fullfile(dir,['1_',num2str(n,'%03d'),'.tif'])); 
end
disp(dir);
end